require "./spec_helper"
# require "minitest/autorun"

describe Amethyst::Base::App do

  describe "#initialize" do
    app = Amethyst::Base::App.new

    it "should set app name" do
      app.name.should eq "application_spec"
    end

    it "should set app directory" do
      Amethyst::Base::App.settings.app_dir.should eq ENV["PWD"]
    end

    it "should set default middleware" do
      Middleware::MiddlewareStack.instance.includes?(Middleware::ShowExceptions).should be_true
      Middleware::MiddlewareStack.instance.includes?(Middleware::Static).should be_true
    end
  end

  describe "#get_app_namespace" do
    it "should return namespace of initialized app" do
      my_app = My::Inner::App.new
      My::Inner::App.settings.namespace.should eq "My::Inner::"
    end

    it "should return empty string if app is in global namespace" do
      global_app = GlobalApp.new
      GlobalApp.settings.namespace.should eq ""
    end
  end

  describe "shortcuts" do
    it "self.settings" do
      Amethyst::Base::App.settings.should be Amethyst::Base::Config.instance
    end

    it "self.routes" do
      Amethyst::Base::App.routes.should be Dispatch::Router.instance
    end

    it "self.logger" do
      Amethyst::Base::App.logger.should be Amethyst::Base::Logger.instance
    end

    it "self.middleware" do
      Amethyst::Base::App.middleware.should be Middleware::MiddlewareStack.instance
    end
  end

  describe "self#use" do
    Amethyst::Base::App.use TestMiddleware
    it " delegates to MiddlewareStack" do
      App.middleware.includes?(TestMiddleware).should be_true
    end
  end
end
