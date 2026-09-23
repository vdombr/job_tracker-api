require 'rivulet_helper'

require 'pry'

RSpec.describe Handlers::Users::Handler do
  subject { described_class.new }

  before do
    DatabaseCleaner[:sequel].start
  end

  after do
    DatabaseCleaner[:sequel].clean
  end

  describe '#create' do
    let(:result) { subject.send(:create, input) }

    context 'with valid params' do
      let(:input) do
        {
          params: {
            name: 'John Doe',
            email: 'user@example.com',
            password: 'Qwe123'
          },
          context: {}
        }
      end

      context 'when user does not exist' do
        it 'response with success' do
          expect(result).to be_success
        end

        it 'returns status created' do
          expect(result.value!.status).to eq 201
        end

        it 'returns created user' do
          expect(result.value!.body).to eq(
            data: {
              name: 'John Doe',
              email: 'user@example.com'
            },
            meta: {}
          )
        end
      end

      context 'when user already present' do
        before do
          User.create(
            name: 'Jane Doe',
            email: 'user@example.com',
            password_hash: 'abc123'
          )
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns status conflict' do
          expect(result.failure.status).to eq 409
        end

        it 'retuns error message' do
          expect(result.failure.body).to include(
            errors: 'This email already exists'
          )
        end
      end
    end

    context 'with invalid params' do
      context 'when email format not match' do
        let(:input) do
          {
            params: {
              name: 'John Doe',
              email: 'user example',
              password: 'Qwe123'
            },
            context: {}
          }
        end

        it 'response with failure' do
          expect(result).to be_failure
        end

        it 'returns unprocessable entity status' do
          expect(result.failure.status).to eq 422
        end

        it 'returns error message' do
          expect(result.failure.body).to eq(
            errors: [
              { field: :email, message: ['email is in invalid format'] }
            ]
          )
        end
      end
    end

    context 'with missing required param' do
      let(:input) do
        {
          params: {
            name: 'John Doe',
            email: 'user@example.com'
          },
          context: {}
        }
      end

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unprocessable entity status' do
        expect(result.failure.status).to eq 422
      end

      it 'returns error message' do
        expect(result.failure.body).to eq(
          errors: [
            { field: :password, message: ['password is missing'] }
          ]
        )
      end
    end
  end

  describe '#show' do
    let(:result) { subject.send(:show, input) }
    let(:input) do
      {
        params: {},
        context: {
          headers: headers
        }
      }
    end

    context 'when user authenticated' do
      let(:user) do
        User.create(
          name: 'John Doe',
          email: 'user@example.com',
          password_hash: 'abc123'
        )
      end
      let(:jwt) { JWT.encode({ sub: user.id }, 'qwe123', 'HS256') }
      let(:headers) do
        { 'Authorization' => jwt }
      end

      it 'response with success' do
        expect(result).to be_success
      end

      it 'returns ok status' do
        expect(result.value!.status).to eq 200
      end

      it 'returns user data' do
        expect(result.value!.body).to eq(
          data: {
            name: user.name,
            email: user.email
          },
          meta: {}
        )
      end
    end

    context 'when user is not authenticated' do
      let(:jwt) { JWT.encode({ sub: '1' }, 'abc321', 'HS256') }
      let(:headers) do
        { 'Authorization' => jwt }
      end

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unauthorized status' do
        expect(result.failure.status).to eq 401
      end
    end

    context 'when jwt token not found in headers' do
      let(:headers) { {} }

      it 'response with failure' do
        expect(result).to be_failure
      end

      it 'returns unauthorized status' do
        expect(result.failure.status).to eq 401
      end
    end
  end
end
