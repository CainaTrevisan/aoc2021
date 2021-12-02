package main

import "core:fmt"
import "core:strconv"
import "core:strings"

Instruction :: struct {
    value:     int,
    direction: enum u8 {FORWARD, DOWN, UP},
}

read_instructions :: proc() -> []Instruction {
    data := string(#load("day2.txt"))
    values := strings.fields(data)
    defer delete(values)
    instructions := make([dynamic]Instruction, len(values) / 2)

    for i := 0; i < len(values); i += 2 {
        switch values[i] {
	  case "forward":
            append(&instructions, Instruction{strconv.atoi(values[i+1]), .FORWARD})
          case "up":
            append(&instructions, Instruction{strconv.atoi(values[i+1]), .UP})
        case "down":
            append(&instructions, Instruction{strconv.atoi(values[i+1]), .DOWN})
        }
    }

    return instructions[:]
}

part_1 :: proc(instructions: []Instruction) {
    horizontal_pos, vertical_pos := 0, 0 
    for i in instructions {
        switch i.direction {
          case .FORWARD: horizontal_pos += i.value  
          case .UP:      vertical_pos   -= i.value  
          case .DOWN:    vertical_pos   += i.value  
        }
    }
    fmt.println(horizontal_pos * vertical_pos)
}

part_2 :: proc(instructions: []Instruction) {
    horizontal_pos, vertical_pos, aim := 0, 0, 0
    for i in instructions {
        switch i.direction {
          case .UP:   aim -= i.value  
          case .DOWN: aim += i.value  
          case .FORWARD:
            horizontal_pos += i.value  
            vertical_pos   += aim * i.value  
        }
    }
    fmt.println(horizontal_pos * vertical_pos)
}

main :: proc() {
    instructions := read_instructions()
    defer delete(instructions)
    part_1(instructions)
    part_2(instructions)
}
