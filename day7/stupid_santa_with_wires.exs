import Bitwise

defmodule Santas_wires do
        def santa_and_his_stupid_unlabeled_wires(operations, variables) do
                calculated_variables = Enum.reduce(operations, {operations, variables}, fn [operation, var1_num, var2_num, output_var], {acc_ops, acc_vars} ->

                        updated_ops = List.delete(acc_ops, [operation, var1_num, var2_num, output_var])

                        value1 = Map.get(acc_vars, var1_num)
                        value2 = Map.get(acc_vars, var2_num)

                        case operation do
                          "ASSIGN" ->
                                if value1 == nil do
                                        if Map.has_key?(acc_vars, var1_num) do
                                                {acc_ops, acc_vars}
                                        else
                                                num = String.to_integer(var1_num)
                                                {updated_ops, assign_op(acc_vars, num, output_var)}
                                        end
                                else
                                        {updated_ops, assign_op(acc_vars, value1, output_var)}
                                end
                          "AND" ->
                                if (value1 == nil &&  var1_num !=="1") || value2 == nil do
                                        {acc_ops, acc_vars}
                                else
                                        if var1_num==="1" do
                                                {updated_ops, and_op(acc_vars, 1, value2, output_var)}
                                        else
                                                {updated_ops, and_op(acc_vars, value1, value2, output_var)}
                                        end
                                end
                          "OR" ->
                                if (value1 == nil &&  var1_num !=="1") || value2 == nil do
                                        {acc_ops, acc_vars}
                                else
                                        if var1_num==="1" do
                                                {updated_ops, or_op(acc_vars, 1, value2, output_var)}
                                        else
                                                {updated_ops, or_op(acc_vars, value1, value2, output_var)}
                                        end
                                end
                          "NOT" ->
                                if value1 == nil do
                                        {acc_ops, acc_vars}
                                else
                                        {updated_ops, not_op(acc_vars, value1, output_var)}
                                end
                          "LSHIFT" ->
                                if value1 == nil do
                                        {acc_ops, acc_vars}
                                else
                                        {updated_ops, lshift_op(acc_vars, value1, var2_num, output_var)}
                                end
                          "RSHIFT" ->
                                if value1 == nil do
                                        {acc_ops, acc_vars}
                                else
                                        {updated_ops, rshift_op(acc_vars, value1, var2_num, output_var)}
                                end
                          true ->
                                {acc_ops, acc_vars}
                        end
                      end)

                if Enum.all?(Map.values(elem(calculated_variables, 1)), fn value -> value != nil end) do
                        elem(calculated_variables, 1)
                        |> Map.get("a")
                else
                        santa_and_his_stupid_unlabeled_wires(elem(calculated_variables, 0), elem(calculated_variables, 1))
                end
                # elem(calculated_variables, 1)
        end

        def assign_op(variables, value, output_var) do
                Map.put(variables, output_var, value)
        end

        def and_op(variables, var1, var2, output_var) do
                Map.put(variables, output_var, var1 &&& var2)
        end

        def or_op(variables, var1, var2, output_var) do
                Map.put(variables, output_var, var1 ||| var2)
        end

        def not_op(variables, var1, output_var) do
                var1 = var1
                |> Integer.to_string(2)
                |> String.replace(~r/[0]/, "2")
                |> String.replace(~r/[1]/, "0")
                |> String.replace(~r/[2]/, "1")
                |> String.to_integer(2)

                Map.put(variables, output_var, var1)
        end

        def lshift_op(variables, var1, num, output_var) do
                Map.put(variables, output_var, var1 <<< num)
        end

        def rshift_op(variables, var1, num, output_var) do
                Map.put(variables, output_var, var1 >>> num)
        end
end

input = File.read!("input.txt")
|> String.trim()
|> String.split(~r/\n/)

regex_variables = ~r/(?<=-> ).*/

variables = Enum.map(input, fn line ->
                Regex.run(regex_variables, line)
        end)
        |> Enum.map(fn [match] -> match end)
        |> Enum.uniq()
        |> Map.new(fn var -> {var, nil} end)

operations = Enum.map(input, fn line ->
                Regex.split(~r/( )/, line)
        end)
        |> Enum.map(fn
                [var1, "RSHIFT", num, "->", output_var] -> ["RSHIFT", var1, String.to_integer(num), output_var]
                [var1, "LSHIFT", num, "->", output_var] -> ["LSHIFT", var1, String.to_integer(num), output_var]
                [var1, "AND", var2, "->", output_var] -> ["AND", var1, var2, output_var]
                [var1, "OR", var2, "->", output_var] -> ["OR", var1, var2, output_var]
                ["NOT", var1, "->", output_var] -> ["NOT", var1, nil, output_var]
                [var1, "->", output_var] -> ["ASSIGN", var1, nil, output_var]
        end)

IO.inspect(operations)

result_a = Santas_wires.santa_and_his_stupid_unlabeled_wires(operations, variables)
|> IO.inspect()

# Start part b
operations_vii = Enum.map(operations, fn
        ["ASSIGN", _, _, "b"] -> ["ASSIGN", Integer.to_string(result_a), nil, "b"]
        other -> other
end)

# Result part b
Santas_wires.santa_and_his_stupid_unlabeled_wires(operations_vii, variables)
|> IO.inspect()
