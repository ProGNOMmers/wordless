require 'spec_helper'

describe User do

  def create(attributes = {})
    default_attributes = { login: StringSequence.new('User %s').next             ,
                           password: 'password'                                  ,
                           password_confirmation: 'password'                     ,
                           email: StringSequence.new('user_%s@example.org').next }
    described_class.create! default_attributes.merge(attributes)
  end

  it "gets users of cms" do
    ids = %w(administrator editor author contributor subscriber).map do |role|
      create(roles: role).id
    end
    expect( ids ).to eq User.pluck(:id)
  end

  # context "user roles" do
    
  #   user = create(roles: ['author'])

  #   expect( user.roles.count ).to be 1
  #   expect( user.roles.map(&:value) ).to eq 'author'

  #   user.update(roles: ['editor'])

  #   expect( user.roles.count ).to be 1
  #   expect( user.roles.map(&:value) ).to eq 'editor'
  # end

  it "gets/sets user options" do
    pending
    user = create(role: 'author')
    
    key = 'some key'

    expect( user.options[key] ).to be_nil
    
    value = 'some value'
    user.options[key, save_and_reload: true] = value
    expect( user.reload.options[key] ).to eq value

    val = 'some other value'
    user.options[key, save_and_reload: true] = value
    expect( user.reload.options[key] ).to eq value
  end

end
