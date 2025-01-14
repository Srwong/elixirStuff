defmodule RoverTest do
  use ExUnit.Case

  test "get_test should return the current state" do
    {:ok, _} = Rover.start_link({9,9,:N,"rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9,9,:N}
  end

  test "handle_cast :go_forward should return updated state" do
    {:no_reply, state} = Rover.handle_cast(:go_forward, %Rover{x: 1, y: 3, dir: :N})
    assert state.x == 1
    assert state.y == 4
    assert state.dir == :N
  end

  test "handle_cast :go_backward should return updated state" do
    {:no_reply, state} = Rover.handle_cast(:go_backward, %Rover{x: 1, y: 3, dir: :N})
    assert state.x == 1
    assert state.y == 2
    assert state.dir == :N
  end

  test "handle :rotate_left should return update state" do
    {:no_reply, state} = Rover.handle_cast(:rotate_left, %Rover{x: 1, y: 3, dir: :N})
    assert state.x == 1
    assert state.y == 3
    assert state.dir == :W
  end

  test "handle :rotate_right should return update state" do
    {:no_reply, state} = Rover.handle_cast(:rotate_left, %Rover{x: 1, y: 3, dir: :N})
    assert state.x == 1
    assert state.y == 3
    assert state.dir == :E
  end

end
