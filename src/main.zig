const std = @import("std");
const hello = @import("./hello.zig");

pub fn main() !void {
    hello.hello();
    // hello.yolo();
}
