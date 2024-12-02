const std = @import("std");

const Tuple = std.meta.Tuple;
const ListsTuple = Tuple(&.{ std.ArrayList(i32), std.ArrayList(i32) });
const Allocator = std.mem.Allocator;

const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

fn cmpByValue(context: void, a: i32, b: i32) bool {
    return std.sort.asc(i32)(context, a, b);
}

fn getLists(allocator: Allocator) !ListsTuple {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    std.log.info("cwd: {s}", .{
        try std.fs.cwd().realpathAlloc(alloc, "."),
    });

    var file = try std.fs.cwd().openFile("input_example.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var left_list = ArrayList(i32).init(allocator);
    var right_list = ArrayList(i32).init(allocator);

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

    return .{ left_list, right_list };
}

pub fn part1() !void {
    var total: i32 = 0;

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const allocator = std.heap.page_allocator;

    try stdout.print("Running part1... \n", .{});

    const lists = try getLists(allocator);

    const left_list = lists[0];
    const right_list = lists[1];

    defer left_list.deinit();
    defer right_list.deinit();

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
    var total: i32 = 0;

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const allocator = std.heap.page_allocator;

    try stdout.print("Running part2... \n", .{});

    const lists = try getLists(allocator);

    const left_list = lists[0];
    const right_list = lists[1];

    defer left_list.deinit();
    defer right_list.deinit();

    for (left_list.items) |item| {
        var count: i32 = 0;
        for (right_list.items) |item2| {
            if (item == item2) {
                count += 1;
            }
        }

        const diff: i32 = item * count;
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
