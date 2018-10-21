import UIKit

// 生成随机数函数
func generatingNumbers (start: Int, end: Int, count: Int) -> [Int] {
    var result:[Int] = []
    
    //根据参数初始化可选值数组
    var nums:[Int] = []
    for i in start...end{
        nums.append(i)
    }
    
    func randomMan() {
        if !nums.isEmpty {
            //随机返回一个数，同时从数组里删除
            let index = Int(arc4random_uniform(UInt32(nums.count)))
            let randNum = nums.remove(at: index)
            result.append(randNum)
        } else {
            //所有值都随机完则返回nil
            print("No num")
        }
    }
    
    for _ in 0...count{
        randomMan()
    }
    return result
}

let queque = DispatchQueue(label: "com.loyep.sortqueue" , attributes: .concurrent)

// 计算耗时
func computingTime(sortMethod: @escaping ()->(Void)) -> () {
    queque.async {
        let start = Date()
        sortMethod()
        print("\(Date().timeIntervalSince(start))")
    }
}

var nums = generatingNumbers(start: 0, end: 300, count: 100)
print("排序前: \n\(nums)")

// 冒泡排序
func bubbleSort(_ array: [Int]) -> [Int] {
    var nums = array
    for i in 0 ..< nums.count {
        for j in 0 ..< nums.count - 1 - i {
            if nums[j] > nums[j+1] {
                nums.swapAt(j, j+1)
            }
        }
    }
    return nums
}

computingTime {
    print("冒泡排序:\n\(bubbleSort(nums)) \n耗时：")
}

// 插入排序
func insertionSort(_ array: [Int]) -> [Int] {
    var nums = array
    for i in 1..<(nums.count - 1) {
        let temp = nums[i]
        for j in (0..<i).reversed() {
            if nums[j] > temp {
                nums.swapAt(j, j+1)
            }
        }
    }
    return nums
}

computingTime {
    print("插入排序:\n\(insertionSort(nums)) \n耗时：")
}

// 选择排序
func selectionSort(_ array: [Int]) -> [Int] {
    var nums = array
    for j in 0..<nums.count - 1 {
        var minIndex = j
        for i in j..<nums.count {
            if nums[minIndex] > nums[i] {
                minIndex = i
            }
        }
        nums.swapAt(j, minIndex)
    }
    return nums
}

computingTime {
    print("选择排序:\n\(selectionSort(nums)) \n耗时：")
}

// 堆排序
func heapSort(_ array: [Int]) -> [Int] {
    
    func heapCreate(_ nums: inout [Int]) {
        let count = nums.count
        for i in (0..<nums.count).reversed() {
            heapAdjast(&nums, startIndex: i, endIndex:count)
        }
    }
    
    func heapAdjast(_ nums: inout [Int], startIndex: Int, endIndex: Int) {
        let temp = nums[startIndex]
        var fatherIndex = startIndex + 1
        var maxChildIndex = 2 * fatherIndex
        
        while maxChildIndex <= endIndex {
            if maxChildIndex < endIndex && nums[maxChildIndex - 1] < nums[maxChildIndex] {
                maxChildIndex = maxChildIndex + 1
            }
            
            if temp < nums[maxChildIndex - 1] {
                nums[fatherIndex - 1] = nums[maxChildIndex - 1]
            } else {
                break
            }
            fatherIndex = maxChildIndex
            maxChildIndex = 2 * fatherIndex
        }
        nums[fatherIndex - 1] = temp
    }
    
    var nums = array
    
    heapCreate(&nums)
    
    for i in (0..<nums.count).reversed() {
        nums.swapAt(0, i)
        heapAdjast(&nums, startIndex: 0, endIndex: i)
    }
    return nums
}

computingTime {
    print("堆排序:\n\(heapSort(nums)) \n耗时：")
}

// 归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    //将数组中的每一个元素放入一个数组中
    var nums: [[Int]] = []
    for item in array {
        var a: [Int] = []
        a.append(item)
        nums.append(a)
    }
    
    //对这个数组中的数组进行合并，直到合并完毕为止
    while nums.count != 1 {
        var i = 0
        while i < nums.count - 1 {
            nums[i] = _mergeArray(nums[i], nums[i + 1])
            nums.remove(at: i + 1)
            i = i + 1
        }
    }
    
    return nums.first!
}

//将两个有序数组进行合并
func _mergeArray(_ firstArray: [Int], _ secondArray: [Int]) -> [Int] {
    var result: Array<Int> = []
    var firstIndex = 0
    var secondIndex = 0
    
    while firstIndex < firstArray.count && secondIndex < secondArray.count {
        if firstArray[firstIndex] < secondArray[secondIndex] {
            result.append(firstArray[firstIndex])
            firstIndex += 1
        } else {
            result.append(secondArray[secondIndex])
            secondIndex += 1
        }
    }
    
    while firstIndex < firstArray.count {
        result.append(firstArray[firstIndex])
        firstIndex += 1
    }
    
    while secondIndex < secondArray.count {
        result.append(secondArray[secondIndex])
        secondIndex += 1
    }
    
    return result
}

computingTime {
    print("归并排序:\n\(mergeSort(nums)) \n耗时：")
}

// 快速排序
func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    let pivot = array[array.count / 2]
    var left: [Int] = []
    var middle: [Int] = []
    var right: [Int] = []
    for item in array.enumerated() {
        if item.element < pivot {
            left.append(item.element)
        } else if item.element >= pivot {
            right.append(item.element)
        } else {
            middle.append(item.element)
        }
    }
    return quickSort(left) + middle + quickSort(right)
}

computingTime {
    print("快速排序:\n\(mergeSort(nums)) \n耗时：")
}
