package main

import "core:fmt"
import "core:strconv"
import "core:strings"

read_input :: proc() -> []int {
    data := string(#load("day1.txt"))
    values := strings.fields(data)
    defer delete(values)
    input := make([]int, len(values))
    for value, i in values {
        input[i] = strconv.atoi(value)
    }
    return input
}

part_1 :: proc(input: []int) {
    total_increased, previous := 0, input[0]    
    for i in input[1:] {
        total_increased += 1 * int(previous < i) 
        previous = i 
    }    
    fmt.println(total_increased)
}

part_2 :: proc(input: []int) {
    total_increased, previous := 0, input[0]
    for i in 3..<len(input) {
        total_increased += 1 * int(previous < input[i]) 
        previous = input[i - 2]
    }
    fmt.println(total_increased)
}

main :: proc() {
    input := read_input()
    defer delete(input)
    part_1(input);
    part_2(input);
}
