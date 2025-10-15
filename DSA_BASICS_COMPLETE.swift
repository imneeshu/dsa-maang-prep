/*
 ================================================================================================
 DSA BASICS COMPLETE SHEET - ALL TOPICS WITH ALL APPROACHES
 ================================================================================================
 This comprehensive guide covers all fundamental Data Structures and Algorithms
 with multiple approaches and implementations in Swift.
 ================================================================================================
*/

import Foundation

// MARK: - 1. ARRAYS & STRINGS

class ArraysAndStrings {
    
    // ==================== BASIC OPERATIONS ====================
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #1: Two Sum                                            │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/two-sum/                         │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an array of integers nums and an integer target, return indices 
     of the two numbers such that they add up to target.
     
     You may assume that each input would have exactly one solution, and 
     you may not use the same element twice.
     
     💡 EXPLANATION:
     We need to find two numbers that sum to target. Hash map approach stores
     each number with its index, allowing O(1) lookup of complement.
     
     📊 EXAMPLES:
     Input: nums = [2,7,11,15], target = 9
     Output: [0,1]
     Explanation: nums[0] + nums[1] = 2 + 7 = 9
     
     Input: nums = [3,2,4], target = 6
     Output: [1,2]
     
     Input: nums = [3,3], target = 6
     Output: [0,1]
     
     ⚙️ CONSTRAINTS:
     • 2 <= nums.length <= 10^4
     • -10^9 <= nums[i] <= 10^9
     • -10^9 <= target <= 10^9
     • Only one valid answer exists
     
     🧪 TEST CASES:
     */
    func testTwoSum() {
        assert(twoSumHashMap([2,7,11,15], 9) == [0,1])
        assert(twoSumHashMap([3,2,4], 6) == [1,2])
        assert(twoSumHashMap([3,3], 6) == [0,1])
        print("✅ Two Sum: All tests passed!")
    }
    
    // APPROACH 1: Brute Force
    func twoSumBruteForce(_ nums: [Int], _ target: Int) -> [Int] {
        // Time: O(n²), Space: O(1)
        // Check every pair of numbers
        for i in 0..<nums.count {
            for j in (i+1)..<nums.count {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
    }
    
    // APPROACH 2: Hash Map (OPTIMAL)
    func twoSumHashMap(_ nums: [Int], _ target: Int) -> [Int] {
        // Time: O(n), Space: O(n)
        // Store complement in hash map for O(1) lookup
        var map: [Int: Int] = [:]
        for (i, num) in nums.enumerated() {
            let complement = target - num
            if let index = map[complement] {
                return [index, i]
            }
            map[num] = i
        }
        return []
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #53: Maximum Subarray                                  │
     │ Difficulty: Medium                                              │
     │ https://leetcode.com/problems/maximum-subarray/                │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an integer array nums, find the subarray with the largest sum,
     and return its sum.
     
     💡 EXPLANATION:
     Kadane's Algorithm: At each position, decide whether to extend the 
     current subarray or start a new one. Keep track of maximum seen.
     
     📊 EXAMPLES:
     Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
     Output: 6
     Explanation: [4,-1,2,1] has the largest sum = 6
     
     Input: nums = [1]
     Output: 1
     
     Input: nums = [5,4,-1,7,8]
     Output: 23
     
     ⚙️ CONSTRAINTS:
     • 1 <= nums.length <= 10^5
     • -10^4 <= nums[i] <= 10^4
     
     🧪 TEST CASES:
     */
    func testMaxSubArray() {
        assert(maxSubArrayKadane([-2,1,-3,4,-1,2,1,-5,4]) == 6)
        assert(maxSubArrayKadane([1]) == 1)
        assert(maxSubArrayKadane([5,4,-1,7,8]) == 23)
        print("✅ Maximum Subarray: All tests passed!")
    }
    
    // APPROACH 1: Kadane's Algorithm (OPTIMAL)
    func maxSubArrayKadane(_ nums: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        var maxSum = nums[0]
        var currentSum = nums[0]
        
        for i in 1..<nums.count {
            currentSum = max(nums[i], currentSum + nums[i])
            maxSum = max(maxSum, currentSum)
        }
        return maxSum
    }
    
    // APPROACH 2: Divide and Conquer
    func maxSubArrayDivideConquer(_ nums: [Int]) -> Int {
        // Time: O(n log n), Space: O(log n)
        func maxCrossingSum(_ arr: [Int], _ left: Int, _ mid: Int, _ right: Int) -> Int {
            var sum = 0
            var leftSum = Int.min
            for i in stride(from: mid, through: left, by: -1) {
                sum += arr[i]
                leftSum = max(leftSum, sum)
            }
            
            sum = 0
            var rightSum = Int.min
            for i in (mid+1)...right {
                sum += arr[i]
                rightSum = max(rightSum, sum)
            }
            return leftSum + rightSum
        }
        
        func maxSubArrayHelper(_ arr: [Int], _ left: Int, _ right: Int) -> Int {
            if left == right {
                return arr[left]
            }
            
            let mid = (left + right) / 2
            return max(
                maxSubArrayHelper(arr, left, mid),
                maxSubArrayHelper(arr, mid + 1, right),
                maxCrossingSum(arr, left, mid, right)
            )
        }
        
        return maxSubArrayHelper(nums, 0, nums.count - 1)
    }
    
    // 1.3 Product of Array Except Self
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        // Time: O(n), Space: O(1) excluding output
        let n = nums.count
        var result = Array(repeating: 1, count: n)
        
        var prefix = 1
        for i in 0..<n {
            result[i] = prefix
            prefix *= nums[i]
        }
        
        var suffix = 1
        for i in stride(from: n-1, through: 0, by: -1) {
            result[i] *= suffix
            suffix *= nums[i]
        }
        
        return result
    }
    
    // 1.4 Container With Most Water
    func maxAreaBruteForce(_ height: [Int]) -> Int {
        // Time: O(n²), Space: O(1)
        var maxArea = 0
        for i in 0..<height.count {
            for j in (i+1)..<height.count {
                let area = min(height[i], height[j]) * (j - i)
                maxArea = max(maxArea, area)
            }
        }
        return maxArea
    }
    
    func maxAreaTwoPointers(_ height: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        var left = 0, right = height.count - 1
        var maxArea = 0
        
        while left < right {
            let area = min(height[left], height[right]) * (right - left)
            maxArea = max(maxArea, area)
            
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return maxArea
    }
    
    // 1.5 Sliding Window Maximum
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        // Time: O(n), Space: O(k)
        var result: [Int] = []
        var deque: [Int] = [] // Store indices
        
        for i in 0..<nums.count {
            // Remove elements outside window
            while !deque.isEmpty && deque[0] < i - k + 1 {
                deque.removeFirst()
            }
            
            // Remove smaller elements
            while !deque.isEmpty && nums[deque.last!] < nums[i] {
                deque.removeLast()
            }
            
            deque.append(i)
            
            if i >= k - 1 {
                result.append(nums[deque[0]])
            }
        }
        return result
    }
    
    // 1.6 Longest Substring Without Repeating Characters
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // Time: O(n), Space: O(min(n, m)) where m is charset size
        var charMap: [Character: Int] = [:]
        var maxLength = 0
        var start = 0
        let chars = Array(s)
        
        for (end, char) in chars.enumerated() {
            if let prevIndex = charMap[char], prevIndex >= start {
                start = prevIndex + 1
            }
            charMap[char] = end
            maxLength = max(maxLength, end - start + 1)
        }
        return maxLength
    }
    
    // 1.7 Valid Anagram - Multiple Approaches
    func isAnagramSorting(_ s: String, _ t: String) -> Bool {
        // Time: O(n log n), Space: O(1)
        return s.sorted() == t.sorted()
    }
    
    func isAnagramHashMap(_ s: String, _ t: String) -> Bool {
        // Time: O(n), Space: O(1) - limited by charset
        if s.count != t.count { return false }
        
        var charCount: [Character: Int] = [:]
        for char in s {
            charCount[char, default: 0] += 1
        }
        
        for char in t {
            charCount[char, default: 0] -= 1
            if charCount[char]! < 0 { return false }
        }
        return true
    }
}

// MARK: - 2. LINKED LISTS

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class LinkedListProblems {
    
    // 2.1 Reverse Linked List - Multiple Approaches
    func reverseListIterative(_ head: ListNode?) -> ListNode? {
        // Time: O(n), Space: O(1)
        var prev: ListNode? = nil
        var current = head
        
        while current != nil {
            let nextTemp = current?.next
            current?.next = prev
            prev = current
            current = nextTemp
        }
        return prev
    }
    
    func reverseListRecursive(_ head: ListNode?) -> ListNode? {
        // Time: O(n), Space: O(n) - recursion stack
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseListRecursive(head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    
    // 2.2 Detect Cycle - Floyd's Algorithm
    func hasCycle(_ head: ListNode?) -> Bool {
        // Time: O(n), Space: O(1)
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                return true
            }
        }
        return false
    }
    
    func detectCycleStart(_ head: ListNode?) -> ListNode? {
        // Time: O(n), Space: O(1)
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                slow = head
                while slow !== fast {
                    slow = slow?.next
                    fast = fast?.next
                }
                return slow
            }
        }
        return nil
    }
    
    // 2.3 Merge Two Sorted Lists
    func mergeTwoListsIterative(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // Time: O(n+m), Space: O(1)
        let dummy = ListNode(0)
        var current = dummy
        var p1 = l1, p2 = l2
        
        while p1 != nil && p2 != nil {
            if p1!.val < p2!.val {
                current.next = p1
                p1 = p1?.next
            } else {
                current.next = p2
                p2 = p2?.next
            }
            current = current.next!
        }
        
        current.next = p1 ?? p2
        return dummy.next
    }
    
    func mergeTwoListsRecursive(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // Time: O(n+m), Space: O(n+m)
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        
        if l1!.val < l2!.val {
            l1?.next = mergeTwoListsRecursive(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoListsRecursive(l1, l2?.next)
            return l2
        }
    }
    
    // 2.4 Remove Nth Node From End
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        // Time: O(n), Space: O(1)
        let dummy = ListNode(0)
        dummy.next = head
        var fast: ListNode? = dummy
        var slow: ListNode? = dummy
        
        for _ in 0...n {
            fast = fast?.next
        }
        
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        slow?.next = slow?.next?.next
        return dummy.next
    }
    
    // 2.5 LRU Cache Implementation
    class LRUCache {
        class DNode {
            var key: Int
            var value: Int
            var prev: DNode?
            var next: DNode?
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.value = value
            }
        }
        
        private var capacity: Int
        private var cache: [Int: DNode] = [:]
        private let head = DNode(0, 0)
        private let tail = DNode(0, 0)
        
        init(_ capacity: Int) {
            self.capacity = capacity
            head.next = tail
            tail.prev = head
        }
        
        func get(_ key: Int) -> Int {
            guard let node = cache[key] else { return -1 }
            moveToHead(node)
            return node.value
        }
        
        func put(_ key: Int, _ value: Int) {
            if let node = cache[key] {
                node.value = value
                moveToHead(node)
            } else {
                let newNode = DNode(key, value)
                cache[key] = newNode
                addToHead(newNode)
                
                if cache.count > capacity {
                    let removed = removeTail()
                    cache.removeValue(forKey: removed.key)
                }
            }
        }
        
        private func addToHead(_ node: DNode) {
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
        }
        
        private func removeNode(_ node: DNode) {
            node.prev?.next = node.next
            node.next?.prev = node.prev
        }
        
        private func moveToHead(_ node: DNode) {
            removeNode(node)
            addToHead(node)
        }
        
        private func removeTail() -> DNode {
            let node = tail.prev!
            removeNode(node)
            return node
        }
    }
}

// MARK: - 3. STACKS & QUEUES

class StacksAndQueues {
    
    // 3.1 Valid Parentheses
    func isValid(_ s: String) -> Bool {
        // Time: O(n), Space: O(n)
        var stack: [Character] = []
        let pairs: [Character: Character] = [")": "(", "}": "{", "]": "["]
        
        for char in s {
            if let open = pairs[char] {
                if stack.isEmpty || stack.removeLast() != open {
                    return false
                }
            } else {
                stack.append(char)
            }
        }
        return stack.isEmpty
    }
    
    // 3.2 Min Stack
    class MinStack {
        private var stack: [(val: Int, min: Int)] = []
        
        func push(_ val: Int) {
            let minVal = stack.isEmpty ? val : min(val, stack.last!.min)
            stack.append((val, minVal))
        }
        
        func pop() {
            stack.removeLast()
        }
        
        func top() -> Int {
            return stack.last!.val
        }
        
        func getMin() -> Int {
            return stack.last!.min
        }
    }
    
    // 3.3 Implement Queue using Stacks
    class MyQueue {
        private var input: [Int] = []
        private var output: [Int] = []
        
        func push(_ x: Int) {
            input.append(x)
        }
        
        func pop() -> Int {
            peek()
            return output.removeLast()
        }
        
        func peek() -> Int {
            if output.isEmpty {
                while !input.isEmpty {
                    output.append(input.removeLast())
                }
            }
            return output.last!
        }
        
        func empty() -> Bool {
            return input.isEmpty && output.isEmpty
        }
    }
    
    // 3.4 Largest Rectangle in Histogram
    func largestRectangleArea(_ heights: [Int]) -> Int {
        // Time: O(n), Space: O(n)
        var stack: [Int] = []
        var maxArea = 0
        var i = 0
        
        while i < heights.count {
            if stack.isEmpty || heights[i] >= heights[stack.last!] {
                stack.append(i)
                i += 1
            } else {
                let top = stack.removeLast()
                let width = stack.isEmpty ? i : i - stack.last! - 1
                maxArea = max(maxArea, heights[top] * width)
            }
        }
        
        while !stack.isEmpty {
            let top = stack.removeLast()
            let width = stack.isEmpty ? i : i - stack.last! - 1
            maxArea = max(maxArea, heights[top] * width)
        }
        
        return maxArea
    }
    
    // 3.5 Daily Temperatures
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        // Time: O(n), Space: O(n)
        var result = Array(repeating: 0, count: temperatures.count)
        var stack: [Int] = []
        
        for i in 0..<temperatures.count {
            while !stack.isEmpty && temperatures[i] > temperatures[stack.last!] {
                let prevIndex = stack.removeLast()
                result[prevIndex] = i - prevIndex
            }
            stack.append(i)
        }
        return result
    }
}

// MARK: - 4. BINARY TREES

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class BinaryTreeProblems {
    
    // 4.1 Tree Traversals - All Approaches
    func inorderTraversalRecursive(_ root: TreeNode?) -> [Int] {
        // Time: O(n), Space: O(h)
        var result: [Int] = []
        func inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            inorder(node.left)
            result.append(node.val)
            inorder(node.right)
        }
        inorder(root)
        return result
    }
    
    func inorderTraversalIterative(_ root: TreeNode?) -> [Int] {
        // Time: O(n), Space: O(h)
        var result: [Int] = []
        var stack: [TreeNode] = []
        var current = root
        
        while current != nil || !stack.isEmpty {
            while current != nil {
                stack.append(current!)
                current = current?.left
            }
            current = stack.removeLast()
            result.append(current!.val)
            current = current?.right
        }
        return result
    }
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        // Time: O(n), Space: O(h)
        guard let root = root else { return [] }
        var result: [Int] = []
        var stack = [root]
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            result.append(node.val)
            if let right = node.right { stack.append(right) }
            if let left = node.left { stack.append(left) }
        }
        return result
    }
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        // Time: O(n), Space: O(h)
        guard let root = root else { return [] }
        var result: [Int] = []
        var stack = [root]
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            result.insert(node.val, at: 0)
            if let left = node.left { stack.append(left) }
            if let right = node.right { stack.append(right) }
        }
        return result
    }
    
    func levelOrderTraversal(_ root: TreeNode?) -> [[Int]] {
        // Time: O(n), Space: O(w) where w is max width
        guard let root = root else { return [] }
        var result: [[Int]] = []
        var queue = [root]
        
        while !queue.isEmpty {
            let levelSize = queue.count
            var level: [Int] = []
            
            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
            result.append(level)
        }
        return result
    }
    
    // 4.2 Maximum Depth
    func maxDepthRecursive(_ root: TreeNode?) -> Int {
        // Time: O(n), Space: O(h)
        guard let root = root else { return 0 }
        return 1 + max(maxDepthRecursive(root.left), maxDepthRecursive(root.right))
    }
    
    func maxDepthIterative(_ root: TreeNode?) -> Int {
        // Time: O(n), Space: O(w)
        guard let root = root else { return 0 }
        var queue = [root]
        var depth = 0
        
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
            depth += 1
        }
        return depth
    }
    
    // 4.3 Validate BST
    func isValidBST(_ root: TreeNode?) -> Bool {
        // Time: O(n), Space: O(h)
        func validate(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
            guard let node = node else { return true }
            
            if let min = min, node.val <= min { return false }
            if let max = max, node.val >= max { return false }
            
            return validate(node.left, min, node.val) && 
                   validate(node.right, node.val, max)
        }
        return validate(root, nil, nil)
    }
    
    // 4.4 Lowest Common Ancestor
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        // Time: O(n), Space: O(h)
        guard let root = root else { return nil }
        
        if root === p || root === q {
            return root
        }
        
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        
        if left != nil && right != nil {
            return root
        }
        
        return left ?? right
    }
    
    // 4.5 Serialize and Deserialize Binary Tree
    func serialize(_ root: TreeNode?) -> String {
        // Time: O(n), Space: O(n)
        var result: [String] = []
        
        func dfs(_ node: TreeNode?) {
            guard let node = node else {
                result.append("null")
                return
            }
            result.append("\(node.val)")
            dfs(node.left)
            dfs(node.right)
        }
        
        dfs(root)
        return result.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        // Time: O(n), Space: O(n)
        var values = data.split(separator: ",").map(String.init)
        var index = 0
        
        func dfs() -> TreeNode? {
            guard index < values.count else { return nil }
            
            let val = values[index]
            index += 1
            
            if val == "null" { return nil }
            
            let node = TreeNode(Int(val)!)
            node.left = dfs()
            node.right = dfs()
            return node
        }
        
        return dfs()
    }
    
    // 4.6 Binary Tree Maximum Path Sum
    func maxPathSum(_ root: TreeNode?) -> Int {
        // Time: O(n), Space: O(h)
        var maxSum = Int.min
        
        func maxGain(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            
            let leftGain = max(maxGain(node.left), 0)
            let rightGain = max(maxGain(node.right), 0)
            
            let pathSum = node.val + leftGain + rightGain
            maxSum = max(maxSum, pathSum)
            
            return node.val + max(leftGain, rightGain)
        }
        
        maxGain(root)
        return maxSum
    }
}

// MARK: - 5. GRAPHS

class GraphProblems {
    
    // 5.1 DFS - Multiple Approaches
    func dfsRecursive(_ graph: [[Int]], _ start: Int) -> [Int] {
        // Time: O(V+E), Space: O(V)
        var visited = Set<Int>()
        var result: [Int] = []
        
        func dfs(_ node: Int) {
            if visited.contains(node) { return }
            visited.insert(node)
            result.append(node)
            
            for neighbor in graph[node] {
                dfs(neighbor)
            }
        }
        
        dfs(start)
        return result
    }
    
    func dfsIterative(_ graph: [[Int]], _ start: Int) -> [Int] {
        // Time: O(V+E), Space: O(V)
        var visited = Set<Int>()
        var stack = [start]
        var result: [Int] = []
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            if visited.contains(node) { continue }
            
            visited.insert(node)
            result.append(node)
            
            for neighbor in graph[node].reversed() {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                }
            }
        }
        return result
    }
    
    // 5.2 BFS
    func bfs(_ graph: [[Int]], _ start: Int) -> [Int] {
        // Time: O(V+E), Space: O(V)
        var visited = Set<Int>()
        var queue = [start]
        var result: [Int] = []
        visited.insert(start)
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            result.append(node)
            
            for neighbor in graph[node] {
                if !visited.contains(neighbor) {
                    visited.insert(neighbor)
                    queue.append(neighbor)
                }
            }
        }
        return result
    }
    
    // 5.3 Number of Islands
    func numIslands(_ grid: [[Character]]) -> Int {
        // Time: O(m*n), Space: O(m*n)
        guard !grid.isEmpty else { return 0 }
        var grid = grid
        var count = 0
        
        func dfs(_ i: Int, _ j: Int) {
            if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count || grid[i][j] == "0" {
                return
            }
            
            grid[i][j] = "0"
            dfs(i+1, j)
            dfs(i-1, j)
            dfs(i, j+1)
            dfs(i, j-1)
        }
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if grid[i][j] == "1" {
                    count += 1
                    dfs(i, j)
                }
            }
        }
        return count
    }
    
    // 5.4 Course Schedule (Cycle Detection)
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        // Time: O(V+E), Space: O(V+E)
        var graph = Array(repeating: [Int](), count: numCourses)
        for prereq in prerequisites {
            graph[prereq[0]].append(prereq[1])
        }
        
        var visited = Array(repeating: 0, count: numCourses) // 0: unvisited, 1: visiting, 2: visited
        
        func hasCycle(_ course: Int) -> Bool {
            if visited[course] == 1 { return true }
            if visited[course] == 2 { return false }
            
            visited[course] = 1
            for prereq in graph[course] {
                if hasCycle(prereq) { return true }
            }
            visited[course] = 2
            return false
        }
        
        for i in 0..<numCourses {
            if hasCycle(i) { return false }
        }
        return true
    }
    
    // 5.5 Clone Graph
    class Node {
        var val: Int
        var neighbors: [Node]
        init(_ val: Int) {
            self.val = val
            self.neighbors = []
        }
    }
    
    func cloneGraph(_ node: Node?) -> Node? {
        // Time: O(V+E), Space: O(V)
        guard let node = node else { return nil }
        var visited: [Int: Node] = [:]
        
        func clone(_ node: Node) -> Node {
            if let cloned = visited[node.val] {
                return cloned
            }
            
            let cloned = Node(node.val)
            visited[node.val] = cloned
            
            for neighbor in node.neighbors {
                cloned.neighbors.append(clone(neighbor))
            }
            
            return cloned
        }
        
        return clone(node)
    }
    
    // 5.6 Dijkstra's Shortest Path
    func dijkstra(_ graph: [[(node: Int, weight: Int)]], _ start: Int) -> [Int] {
        // Time: O((V+E) log V), Space: O(V)
        let n = graph.count
        var dist = Array(repeating: Int.max, count: n)
        dist[start] = 0
        
        var pq = [(dist: 0, node: start)]
        
        while !pq.isEmpty {
            pq.sort { $0.dist > $1.dist }
            let current = pq.removeLast()
            
            if current.dist > dist[current.node] { continue }
            
            for (neighbor, weight) in graph[current.node] {
                let newDist = current.dist + weight
                if newDist < dist[neighbor] {
                    dist[neighbor] = newDist
                    pq.append((newDist, neighbor))
                }
            }
        }
        
        return dist
    }
    
    // 5.7 Topological Sort (Kahn's Algorithm)
    func topologicalSort(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        // Time: O(V+E), Space: O(V+E)
        var graph = Array(repeating: [Int](), count: numCourses)
        var inDegree = Array(repeating: 0, count: numCourses)
        
        for prereq in prerequisites {
            graph[prereq[1]].append(prereq[0])
            inDegree[prereq[0]] += 1
        }
        
        var queue = [Int]()
        for i in 0..<numCourses {
            if inDegree[i] == 0 {
                queue.append(i)
            }
        }
        
        var result: [Int] = []
        while !queue.isEmpty {
            let course = queue.removeFirst()
            result.append(course)
            
            for neighbor in graph[course] {
                inDegree[neighbor] -= 1
                if inDegree[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }
        
        return result.count == numCourses ? result : []
    }
}

// MARK: - 6. DYNAMIC PROGRAMMING

class DynamicProgramming {
    
    // 6.1 Fibonacci - All Approaches
    func fibRecursive(_ n: Int) -> Int {
        // Time: O(2^n), Space: O(n)
        if n <= 1 { return n }
        return fibRecursive(n-1) + fibRecursive(n-2)
    }
    
    func fibMemoization(_ n: Int) -> Int {
        // Time: O(n), Space: O(n)
        var memo = Array(repeating: -1, count: n+1)
        
        func fib(_ n: Int) -> Int {
            if n <= 1 { return n }
            if memo[n] != -1 { return memo[n] }
            memo[n] = fib(n-1) + fib(n-2)
            return memo[n]
        }
        
        return fib(n)
    }
    
    func fibTabulation(_ n: Int) -> Int {
        // Time: O(n), Space: O(n)
        if n <= 1 { return n }
        var dp = Array(repeating: 0, count: n+1)
        dp[1] = 1
        
        for i in 2...n {
            dp[i] = dp[i-1] + dp[i-2]
        }
        return dp[n]
    }
    
    func fibSpaceOptimized(_ n: Int) -> Int {
        // Time: O(n), Space: O(1)
        if n <= 1 { return n }
        var prev2 = 0, prev1 = 1
        
        for _ in 2...n {
            let current = prev1 + prev2
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }
    
    // 6.2 Climbing Stairs
    func climbStairs(_ n: Int) -> Int {
        // Time: O(n), Space: O(1)
        if n <= 2 { return n }
        var prev2 = 1, prev1 = 2
        
        for _ in 3...n {
            let current = prev1 + prev2
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }
    
    // 6.3 Longest Increasing Subsequence
    func lengthOfLIS(_ nums: [Int]) -> Int {
        // Time: O(n²), Space: O(n)
        var dp = Array(repeating: 1, count: nums.count)
        
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
        }
        return dp.max() ?? 0
    }
    
    func lengthOfLISBinarySearch(_ nums: [Int]) -> Int {
        // Time: O(n log n), Space: O(n)
        var tails: [Int] = []
        
        for num in nums {
            var left = 0, right = tails.count
            while left < right {
                let mid = (left + right) / 2
                if tails[mid] < num {
                    left = mid + 1
                } else {
                    right = mid
                }
            }
            
            if left == tails.count {
                tails.append(num)
            } else {
                tails[left] = num
            }
        }
        return tails.count
    }
    
    // 6.4 0/1 Knapsack
    func knapsack(_ weights: [Int], _ values: [Int], _ capacity: Int) -> Int {
        // Time: O(n*W), Space: O(W)
        let n = weights.count
        var dp = Array(repeating: 0, count: capacity + 1)
        
        for i in 0..<n {
            for w in stride(from: capacity, through: weights[i], by: -1) {
                dp[w] = max(dp[w], dp[w - weights[i]] + values[i])
            }
        }
        return dp[capacity]
    }
    
    // 6.5 Coin Change
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        // Time: O(n*amount), Space: O(amount)
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        
        for i in 1...amount {
            for coin in coins {
                if coin <= i {
                    dp[i] = min(dp[i], dp[i - coin] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
    // 6.6 Edit Distance
    func minDistance(_ word1: String, _ word2: String) -> Int {
        // Time: O(m*n), Space: O(m*n)
        let m = word1.count, n = word2.count
        var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
        
        for i in 0...m { dp[i][0] = i }
        for j in 0...n { dp[0][j] = j }
        
        let w1 = Array(word1), w2 = Array(word2)
        
        for i in 1...m {
            for j in 1...n {
                if w1[i-1] == w2[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1])
                }
            }
        }
        return dp[m][n]
    }
    
    // 6.7 Longest Common Subsequence
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        // Time: O(m*n), Space: O(m*n)
        let m = text1.count, n = text2.count
        var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
        
        let t1 = Array(text1), t2 = Array(text2)
        
        for i in 1...m {
            for j in 1...n {
                if t1[i-1] == t2[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
        return dp[m][n]
    }
    
    // 6.8 House Robber
    func rob(_ nums: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        if nums.isEmpty { return 0 }
        if nums.count == 1 { return nums[0] }
        
        var prev2 = 0, prev1 = 0
        
        for num in nums {
            let current = max(prev1, prev2 + num)
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }
    
    // 6.9 Word Break
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        // Time: O(n²*m), Space: O(n)
        let wordSet = Set(wordDict)
        var dp = Array(repeating: false, count: s.count + 1)
        dp[0] = true
        
        let chars = Array(s)
        
        for i in 1...s.count {
            for j in 0..<i {
                if dp[j] {
                    let word = String(chars[j..<i])
                    if wordSet.contains(word) {
                        dp[i] = true
                        break
                    }
                }
            }
        }
        return dp[s.count]
    }
}

// MARK: - 7. SORTING & SEARCHING

class SortingAndSearching {
    
    // 7.1 Quick Sort
    func quickSort(_ arr: inout [Int]) {
        // Average: O(n log n), Worst: O(n²), Space: O(log n)
        func partition(_ low: Int, _ high: Int) -> Int {
            let pivot = arr[high]
            var i = low - 1
            
            for j in low..<high {
                if arr[j] < pivot {
                    i += 1
                    arr.swapAt(i, j)
                }
            }
            arr.swapAt(i + 1, high)
            return i + 1
        }
        
        func sort(_ low: Int, _ high: Int) {
            if low < high {
                let pi = partition(low, high)
                sort(low, pi - 1)
                sort(pi + 1, high)
            }
        }
        
        if !arr.isEmpty {
            sort(0, arr.count - 1)
        }
    }
    
    // 7.2 Merge Sort
    func mergeSort(_ arr: [Int]) -> [Int] {
        // Time: O(n log n), Space: O(n)
        guard arr.count > 1 else { return arr }
        
        let mid = arr.count / 2
        let left = mergeSort(Array(arr[0..<mid]))
        let right = mergeSort(Array(arr[mid..<arr.count]))
        
        return merge(left, right)
    }
    
    func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        var result: [Int] = []
        var i = 0, j = 0
        
        while i < left.count && j < right.count {
            if left[i] < right[j] {
                result.append(left[i])
                i += 1
            } else {
                result.append(right[j])
                j += 1
            }
        }
        
        result.append(contentsOf: left[i...])
        result.append(contentsOf: right[j...])
        return result
    }
    
    // 7.3 Heap Sort
    func heapSort(_ arr: inout [Int]) {
        // Time: O(n log n), Space: O(1)
        func heapify(_ n: Int, _ i: Int) {
            var largest = i
            let left = 2 * i + 1
            let right = 2 * i + 2
            
            if left < n && arr[left] > arr[largest] {
                largest = left
            }
            if right < n && arr[right] > arr[largest] {
                largest = right
            }
            
            if largest != i {
                arr.swapAt(i, largest)
                heapify(n, largest)
            }
        }
        
        let n = arr.count
        
        // Build max heap
        for i in stride(from: n/2 - 1, through: 0, by: -1) {
            heapify(n, i)
        }
        
        // Extract elements
        for i in stride(from: n-1, through: 1, by: -1) {
            arr.swapAt(0, i)
            heapify(i, 0)
        }
    }
    
    // 7.4 Binary Search - All Variants
    func binarySearch(_ arr: [Int], _ target: Int) -> Int {
        // Time: O(log n), Space: O(1)
        var left = 0, right = arr.count - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            
            if arr[mid] == target {
                return mid
            } else if arr[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return -1
    }
    
    func searchRotatedArray(_ nums: [Int], _ target: Int) -> Int {
        // Time: O(log n), Space: O(1)
        var left = 0, right = nums.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            
            if nums[mid] == target {
                return mid
            }
            
            if nums[left] <= nums[mid] {
                if nums[left] <= target && target < nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                if nums[mid] < target && target <= nums[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
    
    // 7.5 Find Peak Element
    func findPeakElement(_ nums: [Int]) -> Int {
        // Time: O(log n), Space: O(1)
        var left = 0, right = nums.count - 1
        
        while left < right {
            let mid = (left + right) / 2
            if nums[mid] > nums[mid + 1] {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return left
    }
    
    // 7.6 Median of Two Sorted Arrays
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // Time: O(log(min(m,n))), Space: O(1)
        let (A, B) = nums1.count < nums2.count ? (nums1, nums2) : (nums2, nums1)
        let m = A.count, n = B.count
        var left = 0, right = m
        
        while left <= right {
            let partitionA = (left + right) / 2
            let partitionB = (m + n + 1) / 2 - partitionA
            
            let maxLeftA = partitionA == 0 ? Int.min : A[partitionA - 1]
            let minRightA = partitionA == m ? Int.max : A[partitionA]
            
            let maxLeftB = partitionB == 0 ? Int.min : B[partitionB - 1]
            let minRightB = partitionB == n ? Int.max : B[partitionB]
            
            if maxLeftA <= minRightB && maxLeftB <= minRightA {
                if (m + n) % 2 == 0 {
                    return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
                } else {
                    return Double(max(maxLeftA, maxLeftB))
                }
            } else if maxLeftA > minRightB {
                right = partitionA - 1
            } else {
                left = partitionA + 1
            }
        }
        return 0.0
    }
}

// MARK: - 8. HEAPS & PRIORITY QUEUES

class HeapProblems {
    
    // 8.1 Min Heap Implementation
    class MinHeap {
        private var heap: [Int] = []
        
        var isEmpty: Bool { heap.isEmpty }
        var size: Int { heap.count }
        
        func peek() -> Int? {
            return heap.first
        }
        
        func insert(_ value: Int) {
            heap.append(value)
            heapifyUp(heap.count - 1)
        }
        
        func extractMin() -> Int? {
            guard !heap.isEmpty else { return nil }
            
            if heap.count == 1 {
                return heap.removeLast()
            }
            
            let min = heap[0]
            heap[0] = heap.removeLast()
            heapifyDown(0)
            return min
        }
        
        private func heapifyUp(_ index: Int) {
            var child = index
            var parent = (child - 1) / 2
            
            while child > 0 && heap[child] < heap[parent] {
                heap.swapAt(child, parent)
                child = parent
                parent = (child - 1) / 2
            }
        }
        
        private func heapifyDown(_ index: Int) {
            var parent = index
            
            while true {
                let left = 2 * parent + 1
                let right = 2 * parent + 2
                var smallest = parent
                
                if left < heap.count && heap[left] < heap[smallest] {
                    smallest = left
                }
                if right < heap.count && heap[right] < heap[smallest] {
                    smallest = right
                }
                
                if smallest == parent { break }
                
                heap.swapAt(parent, smallest)
                parent = smallest
            }
        }
    }
    
    // 8.2 Kth Largest Element
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        // Time: O(n log k), Space: O(k)
        var minHeap = nums[0..<k].sorted()
        
        for i in k..<nums.count {
            if nums[i] > minHeap[0] {
                minHeap[0] = nums[i]
                var index = 0
                while index < k {
                    let left = 2 * index + 1
                    let right = 2 * index + 2
                    var smallest = index
                    
                    if left < k && minHeap[left] < minHeap[smallest] {
                        smallest = left
                    }
                    if right < k && minHeap[right] < minHeap[smallest] {
                        smallest = right
                    }
                    
                    if smallest == index { break }
                    minHeap.swapAt(index, smallest)
                    index = smallest
                }
            }
        }
        return minHeap[0]
    }
    
    // 8.3 Top K Frequent Elements
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        // Time: O(n log k), Space: O(n)
        var freq: [Int: Int] = [:]
        for num in nums {
            freq[num, default: 0] += 1
        }
        
        let sorted = freq.sorted { $0.value > $1.value }
        return Array(sorted.prefix(k).map { $0.key })
    }
    
    // 8.4 Merge K Sorted Lists
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        // Time: O(N log k), Space: O(k)
        guard !lists.isEmpty else { return nil }
        
        var heap: [(val: Int, node: ListNode)] = []
        
        for node in lists.compactMap({ $0 }) {
            heap.append((node.val, node))
        }
        
        heap.sort { $0.val > $1.val }
        
        let dummy = ListNode(0)
        var current = dummy
        
        while !heap.isEmpty {
            let item = heap.removeLast()
            current.next = item.node
            current = current.next!
            
            if let next = item.node.next {
                var index = heap.count
                heap.append((next.val, next))
                
                while index > 0 {
                    let parent = (index - 1) / 2
                    if heap[index].val >= heap[parent].val { break }
                    heap.swapAt(index, parent)
                    index = parent
                }
            }
        }
        
        return dummy.next
    }
}

// MARK: - 9. BACKTRACKING

class BacktrackingProblems {
    
    // 9.1 Permutations
    func permute(_ nums: [Int]) -> [[Int]] {
        // Time: O(n!), Space: O(n!)
        var result: [[Int]] = []
        var current: [Int] = []
        var used = Array(repeating: false, count: nums.count)
        
        func backtrack() {
            if current.count == nums.count {
                result.append(current)
                return
            }
            
            for i in 0..<nums.count {
                if used[i] { continue }
                
                current.append(nums[i])
                used[i] = true
                backtrack()
                current.removeLast()
                used[i] = false
            }
        }
        
        backtrack()
        return result
    }
    
    // 9.2 Combinations
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        // Time: O(C(n,k)), Space: O(C(n,k))
        var result: [[Int]] = []
        var current: [Int] = []
        
        func backtrack(_ start: Int) {
            if current.count == k {
                result.append(current)
                return
            }
            
            for i in start...n {
                current.append(i)
                backtrack(i + 1)
                current.removeLast()
            }
        }
        
        backtrack(1)
        return result
    }
    
    // 9.3 Subsets
    func subsets(_ nums: [Int]) -> [[Int]] {
        // Time: O(2^n), Space: O(2^n)
        var result: [[Int]] = []
        var current: [Int] = []
        
        func backtrack(_ start: Int) {
            result.append(current)
            
            for i in start..<nums.count {
                current.append(nums[i])
                backtrack(i + 1)
                current.removeLast()
            }
        }
        
        backtrack(0)
        return result
    }
    
    // 9.4 Generate Parentheses
    func generateParenthesis(_ n: Int) -> [String] {
        // Time: O(4^n / sqrt(n)), Space: O(4^n / sqrt(n))
        var result: [String] = []
        
        func backtrack(_ current: String, _ open: Int, _ close: Int) {
            if current.count == 2 * n {
                result.append(current)
                return
            }
            
            if open < n {
                backtrack(current + "(", open + 1, close)
            }
            if close < open {
                backtrack(current + ")", open, close + 1)
            }
        }
        
        backtrack("", 0, 0)
        return result
    }
    
    // 9.5 N-Queens
    func solveNQueens(_ n: Int) -> [[String]] {
        // Time: O(n!), Space: O(n²)
        var result: [[String]] = []
        var board = Array(repeating: Array(repeating: ".", count: n), count: n)
        
        func isValid(_ row: Int, _ col: Int) -> Bool {
            for i in 0..<row {
                if board[i][col] == "Q" { return false }
            }
            
            var i = row - 1, j = col - 1
            while i >= 0 && j >= 0 {
                if board[i][j] == "Q" { return false }
                i -= 1
                j -= 1
            }
            
            i = row - 1
            j = col + 1
            while i >= 0 && j < n {
                if board[i][j] == "Q" { return false }
                i -= 1
                j += 1
            }
            
            return true
        }
        
        func backtrack(_ row: Int) {
            if row == n {
                result.append(board.map { $0.joined() })
                return
            }
            
            for col in 0..<n {
                if isValid(row, col) {
                    board[row][col] = "Q"
                    backtrack(row + 1)
                    board[row][col] = "."
                }
            }
        }
        
        backtrack(0)
        return result
    }
    
    // 9.6 Sudoku Solver
    func solveSudoku(_ board: inout [[Character]]) {
        // Time: O(9^(n*n)), Space: O(1)
        func isValid(_ row: Int, _ col: Int, _ num: Character) -> Bool {
            for i in 0..<9 {
                if board[row][i] == num || board[i][col] == num {
                    return false
                }
            }
            
            let startRow = (row / 3) * 3
            let startCol = (col / 3) * 3
            for i in 0..<3 {
                for j in 0..<3 {
                    if board[startRow + i][startCol + j] == num {
                        return false
                    }
                }
            }
            return true
        }
        
        func solve() -> Bool {
            for i in 0..<9 {
                for j in 0..<9 {
                    if board[i][j] == "." {
                        for num in "123456789" {
                            if isValid(i, j, num) {
                                board[i][j] = num
                                if solve() { return true }
                                board[i][j] = "."
                            }
                        }
                        return false
                    }
                }
            }
            return true
        }
        
        solve()
    }
}

// MARK: - 10. BIT MANIPULATION

class BitManipulation {
    
    // 10.1 Basic Operations
    func setBit(_ num: Int, _ i: Int) -> Int {
        return num | (1 << i)
    }
    
    func clearBit(_ num: Int, _ i: Int) -> Int {
        return num & ~(1 << i)
    }
    
    func toggleBit(_ num: Int, _ i: Int) -> Int {
        return num ^ (1 << i)
    }
    
    func checkBit(_ num: Int, _ i: Int) -> Bool {
        return (num & (1 << i)) != 0
    }
    
    // 10.2 Count Set Bits
    func hammingWeight(_ n: Int) -> Int {
        // Time: O(log n), Space: O(1)
        var count = 0
        var num = n
        while num != 0 {
            count += num & 1
            num >>= 1
        }
        return count
    }
    
    func hammingWeightBrianKernighan(_ n: Int) -> Int {
        // Time: O(number of set bits), Space: O(1)
        var count = 0
        var num = n
        while num != 0 {
            num &= (num - 1)
            count += 1
        }
        return count
    }
    
    // 10.3 Single Number (XOR)
    func singleNumber(_ nums: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        return nums.reduce(0, ^)
    }
    
    // 10.4 Power of Two
    func isPowerOfTwo(_ n: Int) -> Bool {
        // Time: O(1), Space: O(1)
        return n > 0 && (n & (n - 1)) == 0
    }
    
    // 10.5 Reverse Bits
    func reverseBits(_ n: Int) -> Int {
        // Time: O(32), Space: O(1)
        var result = 0
        var num = n
        for _ in 0..<32 {
            result <<= 1
            result |= num & 1
            num >>= 1
        }
        return result
    }
    
    // 10.6 Missing Number
    func missingNumber(_ nums: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        var result = nums.count
        for (i, num) in nums.enumerated() {
            result ^= i ^ num
        }
        return result
    }
}

print("✅ DSA Basics Complete Sheet Loaded Successfully!")
print("📚 All fundamental topics with multiple approaches covered")
print("🎯 Ready for MAANG company preparation")

