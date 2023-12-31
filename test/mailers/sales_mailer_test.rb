require "test_helper"

class SalesMailerTest < ActionMailer::TestCase
  test "send_receipt" do
    mail = SalesMailer.send_receipt
    assert_equal "Send receipt", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
