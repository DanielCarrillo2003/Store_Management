class RotationJob < ApplicationJob
    def perform
        rotation = Rotation.create(
            scheduled_at: 3.weeks.from_now,
            completed: false
        )
        if rotation.persisted?
            puts('Una rotacion ha sido agenda para dentro de tres semanas')
        else
            puts "Error al guardar la rotación: #{rotation.errors.full_messages}"
        end
    end
end