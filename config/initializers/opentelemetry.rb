require 'rivulet/opentelemetry'

Rivulet::OTel.configure(service_name: Rivulet.config.app.name.to_s)

Rivulet.config.telemetry.sink = Rivulet::OTel::Sink.new
Rivulet.config.logger = Rivulet::OTel::Logger.new
