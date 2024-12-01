const std = @import("std");

fn cmpByValue(context: void, a: i32, b: i32) bool {
    return std.sort.asc(i32)(context, a, b);
}

pub fn part1() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Running part1... \n", .{});

    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    const ArrayList = std.ArrayList;
    const allocator = std.heap.page_allocator;

    var left_list = ArrayList(i32).init(allocator);
    var right_list = ArrayList(i32).init(allocator);

    defer left_list.deinit();
    defer right_list.deinit();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, " ");

        var count: i32 = 0;
        while (it.next()) |x| {
            if (x.len > 0) {
                const integer = try std.fmt.parseInt(i32, x, 10);

                if (count == 0) {
                    try left_list.append(integer);
                } else {
                    try right_list.append(integer);
                }
                count += 1;
            }
        }
    }

    var total: i32 = 0;

    std.mem.sort(i32, left_list.items, {}, cmpByValue);
    std.mem.sort(i32, right_list.items, {}, cmpByValue);
    for (left_list.items, 0..) |item, i| {
        const item2 = right_list.items[i];

        const diff: i32 = @intCast(@abs(item2 - item));
        total += diff;
    }
    try stdout.print("Part 1 answer: {d}\n", .{total});
    try bw.flush();
}
pub fn part2() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Running part2... \n", .{});

    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    const ArrayList = std.ArrayList;
    const allocator = std.heap.page_allocator;

    var left_list = ArrayList(i32).init(allocator);
    var right_list = ArrayList(i32).init(allocator);

    defer left_list.deinit();
    defer right_list.deinit();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, " ");

        var count: i32 = 0;
        while (it.next()) |x| {
            if (x.len > 0) {
                const integer = try std.fmt.parseInt(i32, x, 10);

                if (count == 0) {
                    try left_list.append(integer);
                } else {
                    try right_list.append(integer);
                }
                count += 1;
            }
        }
    }

    var total: i32 = 0;
    for (left_list.items, 0..) |item, i| {
        var count: i32 = 0;
        for (right_list.items, 0..) |item2, j| {
            if (item == item2) {
                count += 1;
            }
            total += @intCast(i + j);
            total -= @intCast(i + j);
        }
        const iItem: i32 = @intCast(item);
        const diff: i32 = iItem * count;

        total += diff;
    }
    try stdout.print("Part 2 answer: {d}\n", .{total});
    try bw.flush();
}

pub fn main() !void {
    try part1();
    try part2();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
