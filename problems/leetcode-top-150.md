# LeetCode Top 150 Problems - Swift Solutions

> **🌐 This page displays perfectly in browser!**  
> All code is formatted and ready to read on any device.

---

## 📚 Arrays & Strings

### LeetCode #1: Two Sum

**Difficulty:** Easy  
**Companies:** Google★★★ Amazon★★★ Meta★★★ Apple★★★  
**LeetCode Link:** https://leetcode.com/problems/two-sum/  
**🌐 Run Online:** https://swiftfiddle.com

#### 📝 Problem
Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

#### 💡 Explanation
Hash map stores each number with its index. For each number, check if its complement (target - num) exists in the map. This gives O(1) lookup.

#### 📊 Examples

**Example 1:**
```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: nums[0] + nums[1] = 2 + 7 = 9
```

**Example 2:**
```
Input: nums = [3,2,4], target = 6
Output: [1,2]
```

**Example 3:**
```
Input: nums = [3,3], target = 6
Output: [0,1]
```

#### ⚙️ Constraints
- 2 <= nums.length <= 10^4
- -10^9 <= nums[i] <= 10^9
- -10^9 <= target <= 10^9
- Only one valid answer exists

#### 🔧 Solution

**Approach: Hash Map (OPTIMAL)**

⏰ Time: O(n)  
💾 Space: O(n)

```swift
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    // Store complement in hash map for O(1) lookup
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
```

#### 🧪 Test Cases

```swift
// Test 1
assert(twoSum([2,7,11,15], 9) == [0,1])

// Test 2
assert(twoSum([3,2,4], 6) == [1,2])

// Test 3
assert(twoSum([3,3], 6) == [0,1])

// Test 4: Negative numbers
assert(twoSum([-1,-2,-3,-4,-5], -8) == [2,4])

print("✅ All tests passed!")
```

#### 💻 How to Run

**Option 1: SwiftFiddle (Browser)**
1. Go to https://swiftfiddle.com
2. Copy the solution above
3. Paste and click "Run"
4. See results instantly!

**Option 2: Xcode**
1. Open Xcode
2. Create new Playground
3. Copy-paste code
4. Run (⌘+Return)

**Option 3: LeetCode**
1. Go to https://leetcode.com/problems/two-sum/
2. Select Swift
3. Paste solution
4. Submit!

---

### LeetCode #53: Maximum Subarray

**Difficulty:** Medium  
**Companies:** Google★★★ Amazon★★★ Microsoft★★ Apple★★  
**LeetCode Link:** https://leetcode.com/problems/maximum-subarray/  
**🌐 Run Online:** https://swiftfiddle.com

#### 📝 Problem
Given an integer array `nums`, find the subarray with the largest sum, and return its sum.

#### 💡 Explanation
**Kadane's Algorithm:** At each position, decide whether to extend the current subarray or start a new one. Keep track of maximum seen so far.

#### 📊 Examples

**Example 1:**
```
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6
```

**Example 2:**
```
Input: nums = [1]
Output: 1
```

**Example 3:**
```
Input: nums = [5,4,-1,7,8]
Output: 23
Explanation: [5,4,-1,7,8] entire array gives sum 23
```

#### ⚙️ Constraints
- 1 <= nums.length <= 10^5
- -10^4 <= nums[i] <= 10^4

#### 🔧 Solution

**Approach: Kadane's Algorithm (OPTIMAL)**

⏰ Time: O(n) - Single pass  
💾 Space: O(1) - Only two variables

```swift
func maxSubArray(_ nums: [Int]) -> Int {
    var maxSum = nums[0]
    var currentSum = nums[0]
    
    for i in 1..<nums.count {
        // Decide: extend current subarray or start new one
        currentSum = max(nums[i], currentSum + nums[i])
        maxSum = max(maxSum, currentSum)
    }
    
    return maxSum
}
```

#### 🧪 Test Cases

```swift
assert(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6)
assert(maxSubArray([1]) == 1)
assert(maxSubArray([5,4,-1,7,8]) == 23)
assert(maxSubArray([-1]) == -1)
assert(maxSubArray([-2,-1]) == -1)

print("✅ Maximum Subarray: All tests passed!")
```

---

### LeetCode #15: 3Sum

**Difficulty:** Medium  
**Companies:** Google★★★ Amazon★★★ Apple★★★ Meta★★  
**LeetCode Link:** https://leetcode.com/problems/3sum/  

#### 📝 Problem
Given an integer array `nums`, return all the triplets `[nums[i], nums[j], nums[k]]` such that `i != j`, `i != k`, and `j != k`, and `nums[i] + nums[j] + nums[k] == 0`.

The solution set must not contain duplicate triplets.

#### 💡 Explanation
1. Sort the array first
2. For each number, use two pointers to find pairs that sum to -number
3. Skip duplicates to avoid duplicate triplets

#### 📊 Examples

**Example 1:**
```
Input: nums = [-1,0,1,2,-1,-4]
Output: [[-1,-1,2],[-1,0,1]]
```

**Example 2:**
```
Input: nums = [0,1,1]
Output: []
```

**Example 3:**
```
Input: nums = [0,0,0]
Output: [[0,0,0]]
```

#### ⚙️ Constraints
- 3 <= nums.length <= 3000
- -10^5 <= nums[i] <= 10^5

#### 🔧 Solution

**Approach: Sort + Two Pointers**

⏰ Time: O(n²)  
💾 Space: O(1) - excluding output

```swift
func threeSum(_ nums: [Int]) -> [[Int]] {
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
                
                // Skip duplicates
                while left < right && sorted[left] == sorted[left+1] {
                    left += 1
                }
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
```

#### 🧪 Test Cases

```swift
let result1 = threeSum([-1,0,1,2,-1,-4])
assert(result1.count == 2, "Test 1 failed")

assert(threeSum([0,1,1]).isEmpty, "Test 2 failed")
assert(threeSum([0,0,0]) == [[0,0,0]], "Test 3 failed")

print("✅ 3Sum: All tests passed!")
```

---

## 🔗 Quick Links

- [View Full Swift File](../LEETCODE_TOP_150_ANNOTATED.swift) - Download complete code
- [DSA Basics](../DSA_BASICS_COMPLETE.swift) - All fundamental topics
- [MAANG Questions](../MAANG_COMPANIES_QUESTIONS.swift) - Company-specific problems
- [Study Tracker](../STUDY_TRACKER) - Track your progress

---

## 💡 How to Use This Page

1. **📖 Read** - Study problems and solutions on any device
2. **📋 Copy** - Click the code block, copy to clipboard
3. **▶️ Run** - Paste in SwiftFiddle.com or Xcode
4. **✅ Submit** - Go to LeetCode and verify
5. **📊 Track** - Update your progress tracker

---

**🚀 Want more problems?** Check out:
- [DSA Basics - 150+ Problems](dsa-basics)
- [MAANG Questions - 80+ Problems](maang-questions)
- [Advanced Patterns](advanced-patterns)

---

*Last Updated: October 2025*  
*All solutions tested and verified ✅*

