require "./spec_helper"

describe Response do

  response = Response.new(404, "Not Found")

  describe "#header" do
    it "sets header" do
      response.header "Content-Type", "text/html"
      response.headers.size.should eq 1
      response.headers["Content-Type"].should eq "text/html"
    end
  end

  describe "#build" do
    it "should return HTTP::Response" do
      io = IO::Memory.new
      http_resp = HTTP::Server::Response.new io
      http_resp.status_code = 200
      http_resp.headers["Content-Length"] = "5"
      http_resp.output << "hello"

      response.build(http_resp).should be_a HTTP::Server::Response
    end
  end

  describe "#cookie" do
    it "should add a proper simple cookies to 'Set-Cookie' header" do
      response = HttpHlp.res(200, "Ok")
      response.cookie "id", 22
      response.cookie "name", "Amethyst"
      response.headers["Set-Cookie"].should eq "id=22,name=Amethyst"
    end

    it "should add a proper complex cookie to 'Set-Cookie' header" do
      response = HttpHlp.res(200, "Ok")
      response.cookie "id", 22, http_only: true, secure: true, path: "/", domain: "test.com"
      response.headers["Set-Cookie"].should eq "id=22; domain=test.com; path=/; secure; HttpOnly"
    end
  end
end
