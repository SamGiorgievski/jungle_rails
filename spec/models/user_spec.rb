require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'is invalid if password is nil' do
      @user = User.create({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: nil
      })
      expect(@user).not_to be_valid
    end

    it 'is invalid if password_confirmation is nil' do
      @user = User.create({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password_confirmation: nil
      })
      expect(@user).not_to be_valid
    end

    it 'is invalid if password and password_confirmation do not match' do
      @user = User.create({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing",
        password_confirmation: "testing123"
      })
      expect(@user).not_to be_valid
    end

    it 'is invalid if email not unique' do
      @user1 = User.create({
        name: "Sam Giorgievski",
        email: "generic_email@email.com",
        password: "testing"
      })
      @user2 = User.create({
        name: "Sam Giorgievski",
        email: "generic_email@email.com",
        password: "testing"
      })
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
    end

    it 'is invalid without email' do
      @user = User.create({
        name: "Sam Giorgievski",
        email: nil,
        password: "testing"
      })
      expect(@user).not_to be_valid
    end

    it 'is invalid without name' do
      @user = User.create({
        name: nil,
        email: "user@email.com",
        password: "testing"
      })
      expect(@user).not_to be_valid
    end
    
    it 'is invalid if the password is too short' do
      @user = User.create({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "pw"
      })
      expect(@user).not_to be_valid
    end

  end

  
  describe '.authenticate_with_credentials' do
    it 'should return user when valid email and password given' do
      @user = User.new({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing"
      })
      @user.save
      auth_user = User.authenticate_with_credentials("user@email.com", "testing")
      expect(auth_user.email).to eq(@user.email)
    end

    it 'should return false with invalid password' do
      @user = User.new({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("user@email.com", "testing123")
      expect(auth_user).to be_nil
    end

    it 'should return false with invalid email' do
      @user = User.new({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("wrong_email@email.com", "testing")
      expect(auth_user).to be_nil
    end

    it 'should return user when valid email (with spaces) and password given' do
      @user = User.new({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials(" user@email.com ", "testing")
      expect(auth_user.email).to eq(@user.email)
    end

    it 'should return user when valid email (diff cases) and password is given' do
      @user = User.new({
        name: "Sam Giorgievski",
        email: "user@email.com",
        password: "testing"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("UsEr@email.com", "testing")
      expect(auth_user.email).to eq(@user.email)
    end

  end
end
