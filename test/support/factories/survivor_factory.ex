defmodule Tvirus.SurvivorFactory do
  defmacro __using__(_opts) do
    quote do
      def survivor_factory do
        %Tvirus.Player.Survivor{
          name: "Zé",
          age: 18,
          gender: "male",
          infected: false,
          latitude: "15.75",
          longitude: "32.95"
        }
      end
    end
  end
end
