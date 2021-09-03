defmodule Classroom.Storage.Base do
  defmacro __using__(options) do
    module = Keyword.get(options, :module)

    quote do
      use Agent

      def start_link(_options) do
        Agent.start_link(
          fn ->
            Classroom.Storage.Persistence.load(unquote(module))
          end,
          name: __MODULE__
        )
      end

      def add(%unquote(module){id: resource_id} = resource) do
        case get(resource_id) do
          nil ->
            Agent.update(__MODULE__, fn state ->
              new_state = [resource | state]

              unquote(module)
              |> Classroom.Storage.Persistence.persist(new_state)

              new_state
            end)

          %unquote(module){} ->
            {:error, :already_exists}
        end
      end

      def update(%unquote(module){id: resource_id} = resource, params) do
        sanitized_params = Map.delete(params, :id)

        case get(resource_id) do
          %unquote(module){} = resource ->
            updated_resource = Map.merge(resource, sanitized_params)

            Agent.update(__MODULE__, fn state ->
              without_resource =
                state
                |> Enum.reject(fn r ->
                  r.id == resource_id
                end)

              [updated_resource | without_resource]
            end)

          nil ->
            {:error, :not_found}
        end
      end

      def all do
        Agent.get(__MODULE__, fn state -> state end)
      end

      def get(resource_id) do
        Agent.get(__MODULE__, fn state ->
          Enum.find(state, fn resource -> resource.id == resource_id end)
        end)
      end

      def search([{key, value}]) do
        all()
        |> Enum.filter(fn item -> 
          item = Map.from_struct(item)

          case {Map.get(item, key), value} do
            {%Classroom.Storage.Association{resource_id: id}, value} when is_map(value) ->
              id == Map.get(value, :id)

            {data, value} -> data == value
          end
        end)
      end

      def preload(resource) do
        preloaded =
          resource
          |> Map.from_struct()
          |> Enum.filter(fn {key, value} ->
            case value do
              %Classroom.Storage.Association{} ->
                true

              _ ->
                false
            end
          end)
          |> Enum.map(fn {key, value} ->
            module = Module.safe_concat(value.module, Store)

            {key, module.get(value.resource_id)}
          end)
          |> Enum.into(%{})

        Map.merge(resource, preloaded)
      end
    end
  end
end
