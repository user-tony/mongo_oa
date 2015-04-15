class Office::Human::Event < ActiveRecord::Base
    scope :active, -> { where active: true }

    GENRE = { '工作' => 'work', '家庭' => 'home', '外出' => 'out' }
    COLOR = ['darken', 'blue', 'orange', 'greenLight', 'blueLight', 'red']
end
