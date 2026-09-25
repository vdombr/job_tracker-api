require 'rivulet_helper'

RSpec.describe Handlers::JobApps::Handler do
  subject { described_class.new }

  before do
    DatabaseCleaner[:sequel].start
  end

  after do
    DatabaseCleaner[:sequel].clean
  end

  describe 'GET #index' do
    let(:result) { subject.send(:index, input) }

    let(:params) { {} }
    let(:input) do
      {
        params: params,
        context: {
          headers: {
            'Authorization' => auth_token
          }
        }
      }
    end

    context 'when request authenticated' do
      let(:user) do
        User.create(
          name: 'John Doe',
          email: 'user@example.com',
          password_hash: 'abc123'
        )
      end
      let(:user2) do
        User.create(
          name: 'Jane Doe',
          email: 'j.doe@example.com',
          password_hash: 'abc123'
        )
      end
      let(:auth_token) { JWT.encode({ sub: user.id }, 'qwe123', 'HS256') }

      context 'with valid params' do
        let!(:applied_job) do
          create(:job_app, user_id: user.id, current_stage: 'applied')
        end
        let!(:ghosted_job) do
          create(:job_app, user_id: user.id, current_stage: 'ghosted')
        end
        let!(:second_user_job_app) do
          create(:job_app, user_id: user2.id)
        end

        it 'response with success' do
          expect(result).to be_success
        end

        it 'returns ok status' do
          expect(result.value!.status).to eq 200
        end

        it 'returns job apps' do
          expect(result.value!.body).to eq(
            data: [
              {
                id: applied_job.id,
                company: applied_job.company,
                position: applied_job.position,
                url: applied_job.url,
                hr_contact: applied_job.hr_contact,
                commentary: applied_job.commentary,
                current_stage: applied_job.current_stage,
                applied_at: applied_job.applied_at
              },
              {
                id: ghosted_job.id,
                company: ghosted_job.company,
                position: ghosted_job.position,
                url: ghosted_job.url,
                hr_contact: ghosted_job.hr_contact,
                commentary: ghosted_job.commentary,
                current_stage: ghosted_job.current_stage,
                applied_at: ghosted_job.applied_at
              }
            ],
            meta: {
              paginate: {
                limit: 25,
                next_page: nil,
                page: 1,
                prev_page: nil,
                total_pages: 1,
                total_records: 2
              }
            }
          )
        end

        context 'when filtered by stage' do
          let(:params) do
            {
              filter: {
                current_stage: 'offer'
              }
            }
          end

          let!(:offered_job) do
            create(:job_app, user_id: user.id, current_stage: 'offer')
          end

          it 'returns list with offered job app' do
            expect(result.value!.body).to eq(
              data: [
                {
                  id: offered_job.id,
                  company: offered_job.company,
                  position: offered_job.position,
                  url: offered_job.url,
                  hr_contact: offered_job.hr_contact,
                  commentary: offered_job.commentary,
                  current_stage: offered_job.current_stage,
                  applied_at: offered_job.applied_at
                }
              ],
              meta: {
                paginate: {
                  limit: 25,
                  next_page: nil,
                  page: 1,
                  prev_page: nil,
                  total_pages: 1,
                  total_records: 1
                }
              }
            )
          end
        end

        context 'when paginated' do
          let(:params) do
            {
              paginate: {
                limit: 1
              }
            }
          end

          it 'returns list with one job app' do
            expect(result.value!.body[:data].size).to eq 1
            expect(result.value!.body[:meta]).to eq(
              paginate: {
                limit: 1,
                next_page: 2,
                page: 1,
                prev_page: nil,
                total_pages: 2,
                total_records: 2
              }
            )
          end
        end
      end

      context 'with invalid params' do
        let(:params) do
          {
            filter: {
              current_stage: 'foo'
            }
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns error' do
          expect(result.failure.body).to eq(
            errors: [
              {
                field: :current_stage,
                message: ['current_stage must be one of: applied, interviewing, offer, ghosted, rejected']
              }
            ]
          )
        end
      end
    end

    context 'when request unauthenticated' do
      let(:auth_token) { {} }

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unauthenticated status' do
        expect(result.failure.status).to eq 401
      end
    end
  end

  describe 'POST #create' do
    let(:result) { subject.send(:create, input) }

    let(:params) { {} }
    let(:input) do
      {
        params: params,
        context: {
          headers: {
            'Authorization' => auth_token
          }
        }
      }
    end

    context 'when request authenticated' do
      let(:user) do
        User.create(
          name: 'John Doe',
          email: 'user@example.com',
          password_hash: 'abc123'
        )
      end
      let(:auth_token) { JWT.encode({ sub: user.id }, 'qwe123', 'HS256') }

      context 'with valid params' do
        let(:job_app) { build(:job_app, user_id: user.id) }
        let(:params) do
          {
            company: job_app.company,
            position: job_app.position,
            url: job_app.url,
            hr_contact: job_app.hr_contact,
            commentary: job_app.commentary,
            applied_at: job_app.applied_at
          }
        end

        it 'response with success' do
          expect(result).to be_success
        end

        it 'creates a persistent record for user' do
          expect { result }.to change(JobApp.where(user_id: user.id), :count).from(0).to(1)
        end

        it 'returns created status' do
          expect(result.value!.status).to eq 201
        end

        it 'returns created job application' do
          expect(result.value!.body).to include(
            data: {
              id: 1,
              company: job_app.company,
              position: job_app.position,
              url: job_app.url,
              hr_contact: job_app.hr_contact,
              commentary: job_app.commentary,
              current_stage: JobApp::INIT_STAGE,
              applied_at: job_app.applied_at
            },
            meta: {}
          )
        end
      end

      context 'with invalid params' do
        let(:job_app) { build(:job_app) }
        let(:params) do
          {
            company: job_app.company,
            position: job_app.position,
            applied_at: 'invalid date'
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns error' do
          expect(result.failure.body).to eq(
            errors: [
              { field: :applied_at, message: ['applied_at must be a date'] }
            ]
          )
        end
      end

      context 'with missing params' do
        let(:job_app) { build(:job_app) }
        let(:params) do
          {
            company: job_app.company,
            position: job_app.position
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns error' do
          expect(result.failure.body).to eq(
            errors: [
              { field: :applied_at, message: ['applied_at is missing'] }
            ]
          )
        end
      end
    end

    context 'when request unauthenticated' do
      let(:auth_token) { {} }

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unauthenticated status' do
        expect(result.failure.status).to eq 401
      end
    end
  end

  describe 'PATCH #update' do
    let(:result) { subject.send(:update, input) }

    let(:params) { {} }
    let(:input) do
      {
        params: params,
        context: {
          headers: {
            'Authorization' => auth_token
          }
        }
      }
    end

    context 'when request authenticated' do
      let(:user) do
        User.create(
          name: 'John Doe',
          email: 'user@example.com',
          password_hash: 'abc123'
        )
      end
      let(:auth_token) { JWT.encode({ sub: user.id }, 'qwe123', 'HS256') }

      context 'with valid params' do
        let(:job_app) { create(:job_app, user_id: user.id) }
        let(:job_app_id) { job_app.id }
        let(:params) do
          {
            id: job_app_id,
            company: job_app.company,
            position: job_app.position,
            applied_at: job_app.applied_at,
            url: 'http://acme.org'
          }
        end

        it 'response with success' do
          expect(result).to be_success
        end

        it 'returns ok status' do
          expect(result.value!.status).to eq 200
        end

        it 'response with updated job application' do
          expect(result.value!.body).to eq(
            data: {
              id: job_app.id,
              company: job_app.company,
              position: job_app.position,
              url: 'http://acme.org',
              hr_contact: job_app.hr_contact,
              commentary: job_app.commentary,
              current_stage: job_app.current_stage,
              applied_at: job_app.applied_at
            },
            meta: {}
          )
        end

        context 'when user trying to update job application of someone else' do
          let(:user2) do
            User.create(
              name: 'Jane Doe',
              email: 'j.doe@example.com',
              password_hash: 'abc123'
            )
          end
          let(:job_app2) { create(:job_app, user_id: user2.id) }
          let(:job_app_id) { job_app2.id }

          it 'response with failure' do
            expect(result).to be_failure
          end

          it 'returns not found status' do
            expect(result.failure.status).to eq 404
          end
        end
      end

      context 'with invalid params' do
        let(:job_app) { create(:job_app, user_id: user.id) }
        let(:params) do
          {
            id: job_app.id,
            company: job_app.company,
            position: job_app.position,
            applied_at: 'invalid date'
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.body).to eq(
            errors: [
              { field: :applied_at, message: ['applied_at must be a date'] }
            ]
          )
        end
      end

      context 'with missing params' do
        let(:params) do
          {
            company: 'Acme'
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.body).to eq(
            errors: [
              { field: :id, message: ['id is missing'] },
              { field: :position, message: ['position is missing'] },
              { field: :applied_at, message: ['applied_at is missing'] }
            ]
          )
        end
      end
    end

    context 'when request unauthenticated' do
      let(:auth_token) { {} }

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unauthenticated status' do
        expect(result.failure.status).to eq 401
      end
    end
  end
end
