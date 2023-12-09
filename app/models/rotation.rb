class Rotation < ApplicationRecord
  def self.create_initial_rotation
    rotation = create(
      scheduled_at: 3.weeks.from_now,
      completed: false
    )
    if rotation.save
      rotation
    else
      puts "Error al guardar la rotación: #{rotation.errors.full_messages}"
    end
  end
end
