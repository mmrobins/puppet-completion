#!/usr/bin/env rspec
require 'spec_helper'

require 'puppet/face/completion'

Puppet::Face.define(:handsome, '0.0.1') do
  action(:preen) do
    option "--shave BODY_PART" do
      summary "where to shave"
    end
    option "--comb"
    when_invoked {}
  end
  action(:fool) { when_invoked {} }
  action(:food) { when_invoked {} }
  action(:foozball) { when_invoked {} }
end

describe Puppet::Face[:completion, '0.0.1'] do
  before do
    Puppet::Face.stubs(:faces).returns(%w{ pretty handsome smug })
    Puppet::Face['help', :current].stubs(:legacy_applications).returns(['tron', 'helloworld'])

    # need this to allow faces not defined in files to have a current version
    Puppet::Interface::FaceCollection.stubs(:safely_require).returns(true)
  end

  it "should return all faces and legacy apps if no subcommand is passed" do
    subject.bash.should == [
      %w{ handsome helloworld pretty smug tron},
      ''
    ]
  end

  it "should return all faces and legacy apps with the partial subcommand" do
    subject.bash('f').should == [
      %w{ handsome helloworld pretty smug tron},
      'f'
    ]
  end

  it "should return empty array if subcommand matches a legacy application" do
    subject.bash('tron').should == [
      [],
      ''
    ]
  end

  describe "subcommand matches a face" do
    it "should return face actions sorted" do
      subject.bash('handsome').should == [
        %w{ food fool foozball preen },
        ''
      ]
    end

    it "should return action options sorted if action is matched" do
      subject.bash('handsome', 'preen').should == [
        %w{ comb shave },
        ''
      ]
    end
  end
end
