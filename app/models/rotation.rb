class Rotation < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["id", "username", "scheduled_at", "completed_at", "completed"]
  end
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
