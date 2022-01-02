defmodule Tvirus.SurvivorFactory do
  defmacro __using__(_opts) do
    quote do
      def survivor_factory do
        %Tvirus.Player.Survivor{
          name: "Zé",
          age: 18,
          gender: "male",
          infected: false
        }
      end
    end
  end
end
