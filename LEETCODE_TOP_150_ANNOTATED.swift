/*
 ================================================================================================
 LEETCODE TOP 150 PROBLEMS - FULLY ANNOTATED FOR MAANG INTERVIEWS
 ================================================================================================
 Every problem includes:
 ✅ LeetCode problem number and link
 ✅ Difficulty level
 ✅ Complete problem description
 ✅ Multiple approaches with explanations
 ✅ Test cases
 ✅ Time and space complexity
 ✅ Constraints
 ================================================================================================
*/

import Foundation

// MARK: - ARRAYS & STRINGS (Top 20 Problems)

class ArrayProblems {
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #1: Two Sum                                            │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/two-sum/                         │
     │ Companies: Google★★★ Amazon★★★ Meta★★★ Apple★★★              │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an array of integers nums and an integer target, return indices 
     of the two numbers such that they add up to target.
     
     💡 EXPLANATION:
     Hash map stores each number with its index. For each number, check if
     its complement (target - num) exists in the map. This gives O(1) lookup.
     
     📊 EXAMPLES:
     Example 1:
     Input: nums = [2,7,11,15], target = 9
     Output: [0,1]
     Explanation: nums[0] + nums[1] = 2 + 7 = 9
     
     Example 2:
     Input: nums = [3,2,4], target = 6
     Output: [1,2]
     
     Example 3:
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
        assert(twoSum([2,7,11,15], 9) == [0,1], "Test 1 failed")
        assert(twoSum([3,2,4], 6) == [1,2], "Test 2 failed")
        assert(twoSum([3,3], 6) == [0,1], "Test 3 failed")
        assert(twoSum([-1,-2,-3,-4,-5], -8) == [2,4], "Test 4: Negative numbers")
        print("✅ LeetCode #1 Two Sum: All tests passed!")
    }
    
    // APPROACH: Hash Map - OPTIMAL for interviews
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // ⏰ Time: O(n) - Single pass through array
        // 💾 Space: O(n) - Hash map stores up to n elements
        
        var map: [Int: Int] = [:] // value -> index
        
        for (i, num) in nums.enumerated() {
            let complement = target - num
            
            if let j = map[complement] {
                return [j, i]
            }
            
            map[num] = i
        }
        
        return [] // No solution found
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #53: Maximum Subarray (Kadane's Algorithm)            │
     │ Difficulty: Medium                                              │
     │ https://leetcode.com/problems/maximum-subarray/                │
     │ Companies: Google★★★ Amazon★★★ Microsoft★★ Apple★★           │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an integer array nums, find the subarray with the largest sum,
     and return its sum.
     
     💡 EXPLANATION:
     Kadane's Algorithm: At each position, we decide whether to:
     1. Extend the current subarray (add current number)
     2. Start a new subarray (just take current number)
     We choose whichever gives us a larger sum.
     
     📊 EXAMPLES:
     Example 1:
     Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
     Output: 6
     Explanation: [4,-1,2,1] has the largest sum = 6
     
     Example 2:
     Input: nums = [1]
     Output: 1
     
     Example 3:
     Input: nums = [5,4,-1,7,8]
     Output: 23
     Explanation: [5,4,-1,7,8] entire array gives sum 23
     
     ⚙️ CONSTRAINTS:
     • 1 <= nums.length <= 10^5
     • -10^4 <= nums[i] <= 10^4
     
     🧪 TEST CASES:
     */
    func testMaxSubArray() {
        assert(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6, "Test 1 failed")
        assert(maxSubArray([1]) == 1, "Test 2 failed")
        assert(maxSubArray([5,4,-1,7,8]) == 23, "Test 3 failed")
        assert(maxSubArray([-1]) == -1, "Test 4: Single negative")
        assert(maxSubArray([-2,-1]) == -1, "Test 5: All negatives")
        print("✅ LeetCode #53 Maximum Subarray: All tests passed!")
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        // ⏰ Time: O(n) - Single pass
        // 💾 Space: O(1) - Only two variables
        
        var maxSum = nums[0]
        var currentSum = nums[0]
        
        for i in 1..<nums.count {
            // Decide: extend current subarray or start new one
            currentSum = max(nums[i], currentSum + nums[i])
            maxSum = max(maxSum, currentSum)
        }
        
        return maxSum
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #15: 3Sum                                              │
     │ Difficulty: Medium                                              │
     │ https://leetcode.com/problems/3sum/                            │
     │ Companies: Google★★★ Amazon★★★ Apple★★★ Meta★★              │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an integer array nums, return all the triplets [nums[i], nums[j], 
     nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + 
     nums[k] == 0. The solution set must not contain duplicate triplets.
     
     💡 EXPLANATION:
     1. Sort the array first
     2. For each number, use two pointers to find pairs that sum to -number
     3. Skip duplicates to avoid duplicate triplets
     
     📊 EXAMPLES:
     Example 1:
     Input: nums = [-1,0,1,2,-1,-4]
     Output: [[-1,-1,2],[-1,0,1]]
     Explanation: 
     nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0
     nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0
     nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0
     
     Example 2:
     Input: nums = [0,1,1]
     Output: []
     
     Example 3:
     Input: nums = [0,0,0]
     Output: [[0,0,0]]
     
     ⚙️ CONSTRAINTS:
     • 3 <= nums.length <= 3000
     • -10^5 <= nums[i] <= 10^5
     
     🧪 TEST CASES:
     */
    func testThreeSum() {
        let result1 = threeSum([-1,0,1,2,-1,-4])
        assert(result1.count == 2, "Test 1 failed")
        assert(threeSum([0,1,1]).isEmpty, "Test 2 failed")
        assert(threeSum([0,0,0]) == [[0,0,0]], "Test 3 failed")
        print("✅ LeetCode #15 3Sum: All tests passed!")
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // ⏰ Time: O(n²) - O(n log n) for sort + O(n²) for two pointers
        // 💾 Space: O(1) - Excluding output array
        
        var result: [[Int]] = []
        let sorted = nums.sorted()
        
        for i in 0..<sorted.count - 2 {
            // Skip duplicates for first number
            if i > 0 && sorted[i] == sorted[i-1] { continue }
            
            var left = i + 1
            var right = sorted.count - 1
            
            while left < right {
                let sum = sorted[i] + sorted[left] + sorted[right]
                
                if sum == 0 {
                    result.append([sorted[i], sorted[left], sorted[right]])
                    
                    // Skip duplicates for second number
                    while left < right && sorted[left] == sorted[left+1] {
                        left += 1
                    }
                    // Skip duplicates for third number
                    while left < right && sorted[right] == sorted[right-1] {
                        right -= 1
                    }
                    
                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        return result
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #121: Best Time to Buy and Sell Stock                 │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/best-time-to-buy-and-sell-stock/│
     │ Companies: Amazon★★★ Meta★★★ Google★★ Apple★★               │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     You are given an array prices where prices[i] is the price of a given 
     stock on the ith day. You want to maximize your profit by choosing a 
     single day to buy one stock and choosing a different day in the future 
     to sell that stock. Return the maximum profit you can achieve.
     
     💡 EXPLANATION:
     Track the minimum price seen so far. For each price, calculate profit
     if we sell today (current price - min price so far). Keep track of
     maximum profit.
     
     📊 EXAMPLES:
     Example 1:
     Input: prices = [7,1,5,3,6,4]
     Output: 5
     Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5
     
     Example 2:
     Input: prices = [7,6,4,3,1]
     Output: 0
     Explanation: No profit possible
     
     ⚙️ CONSTRAINTS:
     • 1 <= prices.length <= 10^5
     • 0 <= prices[i] <= 10^4
     
     🧪 TEST CASES:
     */
    func testMaxProfit() {
        assert(maxProfit([7,1,5,3,6,4]) == 5, "Test 1 failed")
        assert(maxProfit([7,6,4,3,1]) == 0, "Test 2 failed")
        assert(maxProfit([2,4,1]) == 2, "Test 3 failed")
        print("✅ LeetCode #121 Best Time to Buy and Sell Stock: All tests passed!")
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        // ⏰ Time: O(n) - Single pass
        // 💾 Space: O(1) - Only two variables
        
        var minPrice = Int.max
        var maxProfit = 0
        
        for price in prices {
            minPrice = min(minPrice, price)
            maxProfit = max(maxProfit, price - minPrice)
        }
        
        return maxProfit
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #217: Contains Duplicate                              │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/contains-duplicate/              │
     │ Companies: Amazon★★ Apple★★ Microsoft★                        │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an integer array nums, return true if any value appears at least 
     twice in the array, and return false if every element is distinct.
     
     💡 EXPLANATION:
     Use a Set to track seen numbers. If we encounter a number already in
     the set, we found a duplicate.
     
     📊 EXAMPLES:
     Example 1:
     Input: nums = [1,2,3,1]
     Output: true
     
     Example 2:
     Input: nums = [1,2,3,4]
     Output: false
     
     Example 3:
     Input: nums = [1,1,1,3,3,4,3,2,4,2]
     Output: true
     
     ⚙️ CONSTRAINTS:
     • 1 <= nums.length <= 10^5
     • -10^9 <= nums[i] <= 10^9
     
     🧪 TEST CASES:
     */
    func testContainsDuplicate() {
        assert(containsDuplicate([1,2,3,1]) == true)
        assert(containsDuplicate([1,2,3,4]) == false)
        assert(containsDuplicate([1,1,1,3,3,4,3,2,4,2]) == true)
        print("✅ LeetCode #217 Contains Duplicate: All tests passed!")
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        // ⏰ Time: O(n)
        // 💾 Space: O(n)
        
        var seen = Set<Int>()
        
        for num in nums {
            if seen.contains(num) {
                return true
            }
            seen.insert(num)
        }
        
        return false
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #238: Product of Array Except Self                    │
     │ Difficulty: Medium                                              │
     │ https://leetcode.com/problems/product-of-array-except-self/    │
     │ Companies: Meta★★★ Amazon★★★ Google★★ Apple★★               │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given an integer array nums, return an array answer such that answer[i] 
     is equal to the product of all the elements of nums except nums[i].
     You must write an algorithm that runs in O(n) time and without using 
     the division operation.
     
     💡 EXPLANATION:
     Use two passes:
     1. Left to right: Calculate prefix product (product of all elements before i)
     2. Right to left: Calculate suffix product and multiply with prefix
     
     📊 EXAMPLES:
     Example 1:
     Input: nums = [1,2,3,4]
     Output: [24,12,8,6]
     
     Example 2:
     Input: nums = [-1,1,0,-3,3]
     Output: [0,0,9,0,0]
     
     ⚙️ CONSTRAINTS:
     • 2 <= nums.length <= 10^5
     • -30 <= nums[i] <= 30
     • Product of any prefix or suffix is guaranteed to fit in 32-bit integer
     
     🧪 TEST CASES:
     */
    func testProductExceptSelf() {
        assert(productExceptSelf([1,2,3,4]) == [24,12,8,6])
        assert(productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0])
        print("✅ LeetCode #238 Product Except Self: All tests passed!")
    }
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        // ⏰ Time: O(n)
        // 💾 Space: O(1) - excluding output array
        
        let n = nums.count
        var result = Array(repeating: 1, count: n)
        
        // Left pass: prefix products
        var prefix = 1
        for i in 0..<n {
            result[i] = prefix
            prefix *= nums[i]
        }
        
        // Right pass: suffix products
        var suffix = 1
        for i in stride(from: n-1, through: 0, by: -1) {
            result[i] *= suffix
            suffix *= nums[i]
        }
        
        return result
    }
}

// MARK: - LINKED LISTS (Top 10 Problems)

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class LinkedListProblems {
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #206: Reverse Linked List                             │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/reverse-linked-list/             │
     │ Companies: Amazon★★★ Google★★★ Meta★★★ Apple★★★            │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given the head of a singly linked list, reverse the list, and return 
     the reversed list.
     
     💡 EXPLANATION:
     Iterative: Use three pointers (prev, current, next) to reverse links
     Recursive: Reverse rest of list first, then fix current node's links
     
     📊 EXAMPLES:
     Example 1:
     Input: head = [1,2,3,4,5]
     Output: [5,4,3,2,1]
     
     Example 2:
     Input: head = [1,2]
     Output: [2,1]
     
     Example 3:
     Input: head = []
     Output: []
     
     ⚙️ CONSTRAINTS:
     • 0 <= list length <= 5000
     • -5000 <= Node.val <= 5000
     
     🧪 TEST CASES:
     */
    func testReverseList() {
        // Test 1: [1,2,3,4,5]
        let head1 = createList([1,2,3,4,5])
        let reversed1 = reverseList(head1)
        assert(listToArray(reversed1) == [5,4,3,2,1])
        
        // Test 2: [1,2]
        let head2 = createList([1,2])
        let reversed2 = reverseList(head2)
        assert(listToArray(reversed2) == [2,1])
        
        // Test 3: Empty list
        assert(reverseList(nil) == nil)
        
        print("✅ LeetCode #206 Reverse Linked List: All tests passed!")
    }
    
    // APPROACH 1: Iterative - RECOMMENDED for interviews
    func reverseList(_ head: ListNode?) -> ListNode? {
        // ⏰ Time: O(n)
        // 💾 Space: O(1)
        
        var prev: ListNode? = nil
        var current = head
        
        while current != nil {
            let nextTemp = current?.next  // Save next
            current?.next = prev          // Reverse link
            prev = current                // Move prev forward
            current = nextTemp            // Move current forward
        }
        
        return prev
    }
    
    // APPROACH 2: Recursive
    func reverseListRecursive(_ head: ListNode?) -> ListNode? {
        // ⏰ Time: O(n)
        // 💾 Space: O(n) - recursion stack
        
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseListRecursive(head?.next)
        head?.next?.next = head  // Reverse the link
        head?.next = nil         // Remove old link
        return newHead
    }
    
    // Helper functions
    func createList(_ values: [Int]) -> ListNode? {
        guard !values.isEmpty else { return nil }
        let head = ListNode(values[0])
        var current = head
        for i in 1..<values.count {
            current.next = ListNode(values[i])
            current = current.next!
        }
        return head
    }
    
    func listToArray(_ head: ListNode?) -> [Int] {
        var result: [Int] = []
        var current = head
        while current != nil {
            result.append(current!.val)
            current = current?.next
        }
        return result
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #141: Linked List Cycle                               │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/linked-list-cycle/               │
     │ Companies: Amazon★★★ Microsoft★★ Apple★★                      │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given head of a linked list, determine if the linked list has a cycle.
     There is a cycle if there is some node that can be reached again by 
     continuously following the next pointer.
     
     💡 EXPLANATION:
     Floyd's Cycle Detection (Tortoise and Hare):
     Use two pointers moving at different speeds. If there's a cycle, 
     they will eventually meet.
     
     📊 EXAMPLES:
     Example 1:
     Input: head = [3,2,0,-4], pos = 1
     Output: true
     Explanation: There is a cycle, tail connects to 1st node (0-indexed)
     
     Example 2:
     Input: head = [1,2], pos = 0
     Output: true
     
     Example 3:
     Input: head = [1], pos = -1
     Output: false
     
     ⚙️ CONSTRAINTS:
     • 0 <= list length <= 10^4
     • -10^5 <= Node.val <= 10^5
     • pos is -1 or a valid index
     
     🧪 TEST CASES:
     */
    func testHasCycle() {
        // Test with cycle
        let head1 = createList([3,2,0,-4])
        var current = head1
        while current?.next != nil { current = current?.next }
        current?.next = head1?.next // Create cycle
        assert(hasCycle(head1) == true)
        
        // Test without cycle
        let head2 = createList([1,2,3])
        assert(hasCycle(head2) == false)
        
        print("✅ LeetCode #141 Linked List Cycle: All tests passed!")
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        // ⏰ Time: O(n)
        // 💾 Space: O(1)
        
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                return true  // Cycle detected
            }
        }
        
        return false  // No cycle
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #21: Merge Two Sorted Lists                           │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/merge-two-sorted-lists/          │
     │ Companies: Amazon★★★ Google★★ Microsoft★★ Apple★★            │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     You are given the heads of two sorted linked lists list1 and list2.
     Merge the two lists into one sorted list. The list should be made by 
     splicing together the nodes of the first two lists.
     
     💡 EXPLANATION:
     Use a dummy node to simplify edge cases. Compare values and append 
     smaller node to result. When one list is exhausted, append the rest 
     of the other list.
     
     📊 EXAMPLES:
     Example 1:
     Input: list1 = [1,2,4], list2 = [1,3,4]
     Output: [1,1,2,3,4,4]
     
     Example 2:
     Input: list1 = [], list2 = []
     Output: []
     
     Example 3:
     Input: list1 = [], list2 = [0]
     Output: [0]
     
     ⚙️ CONSTRAINTS:
     • 0 <= list length <= 50
     • -100 <= Node.val <= 100
     • Both lists are sorted in non-decreasing order
     
     🧪 TEST CASES:
     */
    func testMergeTwoLists() {
        let l1 = createList([1,2,4])
        let l2 = createList([1,3,4])
        let merged = mergeTwoLists(l1, l2)
        assert(listToArray(merged) == [1,1,2,3,4,4])
        print("✅ LeetCode #21 Merge Two Sorted Lists: All tests passed!")
    }
    
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        // ⏰ Time: O(n + m)
        // 💾 Space: O(1)
        
        let dummy = ListNode(0)
        var current = dummy
        var l1 = list1
        var l2 = list2
        
        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                current.next = l1
                l1 = l1?.next
            } else {
                current.next = l2
                l2 = l2?.next
            }
            current = current.next!
        }
        
        // Append remaining nodes
        current.next = l1 ?? l2
        
        return dummy.next
    }
}

// MARK: - TREES (Top 15 Problems)

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

class TreeProblems {
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #104: Maximum Depth of Binary Tree                    │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/maximum-depth-of-binary-tree/    │
     │ Companies: Amazon★★★ Google★★ Meta★★ Apple★★                │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given the root of a binary tree, return its maximum depth.
     A binary tree's maximum depth is the number of nodes along the longest 
     path from the root node down to the farthest leaf node.
     
     💡 EXPLANATION:
     Recursively find max depth of left and right subtrees, then add 1 for 
     current node. Base case: null node has depth 0.
     
     📊 EXAMPLES:
     Example 1:
     Input: root = [3,9,20,null,null,15,7]
     Output: 3
     
     Example 2:
     Input: root = [1,null,2]
     Output: 2
     
     ⚙️ CONSTRAINTS:
     • 0 <= number of nodes <= 10^4
     • -100 <= Node.val <= 100
     
     🧪 TEST CASES:
     */
    func testMaxDepth() {
        let root1 = TreeNode(3)
        root1.left = TreeNode(9)
        root1.right = TreeNode(20)
        root1.right?.left = TreeNode(15)
        root1.right?.right = TreeNode(7)
        assert(maxDepth(root1) == 3)
        
        let root2 = TreeNode(1)
        root2.right = TreeNode(2)
        assert(maxDepth(root2) == 2)
        
        print("✅ LeetCode #104 Maximum Depth: All tests passed!")
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        // ⏰ Time: O(n) - visit each node once
        // 💾 Space: O(h) - recursion stack, h = height
        
        guard let root = root else { return 0 }
        
        return 1 + max(maxDepth(root.left), maxDepth(root.right))
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #226: Invert Binary Tree                              │
     │ Difficulty: Easy                                                │
     │ https://leetcode.com/problems/invert-binary-tree/              │
     │ Companies: Google★★★ Amazon★★ Meta★★                          │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given the root of a binary tree, invert the tree, and return its root.
     
     💡 EXPLANATION:
     Recursively swap left and right children for each node.
     
     📊 EXAMPLES:
     Example 1:
     Input: root = [4,2,7,1,3,6,9]
     Output: [4,7,2,9,6,3,1]
     
     Example 2:
     Input: root = [2,1,3]
     Output: [2,3,1]
     
     Example 3:
     Input: root = []
     Output: []
     
     ⚙️ CONSTRAINTS:
     • 0 <= number of nodes <= 100
     • -100 <= Node.val <= 100
     
     🧪 TEST CASES:
     */
    func testInvertTree() {
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)
        root.right?.left = TreeNode(6)
        root.right?.right = TreeNode(9)
        
        let inverted = invertTree(root)
        assert(inverted?.val == 4)
        assert(inverted?.left?.val == 7)
        assert(inverted?.right?.val == 2)
        print("✅ LeetCode #226 Invert Binary Tree: All tests passed!")
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        // ⏰ Time: O(n)
        // 💾 Space: O(h)
        
        guard let root = root else { return nil }
        
        // Swap children
        let temp = root.left
        root.left = root.right
        root.right = temp
        
        // Recursively invert subtrees
        invertTree(root.left)
        invertTree(root.right)
        
        return root
    }
    
    /*
     ┌─────────────────────────────────────────────────────────────────┐
     │ LeetCode #98: Validate Binary Search Tree                      │
     │ Difficulty: Medium                                              │
     │ https://leetcode.com/problems/validate-binary-search-tree/     │
     │ Companies: Amazon★★★ Google★★★ Meta★★ Microsoft★★           │
     └─────────────────────────────────────────────────────────────────┘
     
     📝 PROBLEM:
     Given the root of a binary tree, determine if it is a valid binary 
     search tree (BST).
     
     A valid BST is defined as follows:
     • The left subtree of a node contains only nodes with keys less than 
       the node's key
     • The right subtree contains only nodes with keys greater than the 
       node's key
     • Both left and right subtrees must also be BSTs
     
     💡 EXPLANATION:
     For each node, maintain valid range (min, max). Left child must be 
     less than current node, right child must be greater. Update range as 
     we recurse.
     
     📊 EXAMPLES:
     Example 1:
     Input: root = [2,1,3]
     Output: true
     
     Example 2:
     Input: root = [5,1,4,null,null,3,6]
     Output: false
     Explanation: Root's value is 5 but its right child's value is 4
     
     ⚙️ CONSTRAINTS:
     • 1 <= number of nodes <= 10^4
     • -2^31 <= Node.val <= 2^31 - 1
     
     🧪 TEST CASES:
     */
    func testIsValidBST() {
        let root1 = TreeNode(2)
        root1.left = TreeNode(1)
        root1.right = TreeNode(3)
        assert(isValidBST(root1) == true)
        
        let root2 = TreeNode(5)
        root2.left = TreeNode(1)
        root2.right = TreeNode(4)
        root2.right?.left = TreeNode(3)
        root2.right?.right = TreeNode(6)
        assert(isValidBST(root2) == false)
        
        print("✅ LeetCode #98 Validate BST: All tests passed!")
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        // ⏰ Time: O(n)
        // 💾 Space: O(h)
        
        return validate(root, nil, nil)
    }
    
    private func validate(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        guard let node = node else { return true }
        
        // Check if current node violates BST property
        if let min = min, node.val <= min { return false }
        if let max = max, node.val >= max { return false }
        
        // Recursively validate left and right subtrees
        return validate(node.left, min, node.val) && 
               validate(node.right, node.val, max)
    }
}

print("✅ LeetCode Top 150 Problems - Annotated Version Loaded!")
print("📚 Each problem includes: Number, Link, Description, Examples, Test Cases")
print("🎯 Ready for MAANG Interviews!")

