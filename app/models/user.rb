class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :ots, :class_name => "Ot", :foreign_key => :created_by
  has_many :tasks, :class_name => "Task", :foreign_key => :current_user_id
  has_many :audits
  belongs_to :role

  def name_and_load
    count = 0
    tasks.each do |task|
      count += 1 if task.completed_on.nil?
    end
    "#{user_name} (#{count})"
  end
end
