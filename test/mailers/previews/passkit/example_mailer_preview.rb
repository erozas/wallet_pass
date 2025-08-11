module Passkit
  class ExampleMailerPreview < ActionMailer::Preview
    def example_email
      Passkit::ExampleMailer.example_email
    end
  end
end