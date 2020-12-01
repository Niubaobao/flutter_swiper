//1********* 冒泡排序
/*
 冒泡就是两层循环，time:O(N^2)
思考：冒泡排序是稳定的吗？
解答：不稳定，因为出现了交换。
*/

const arr = [5,2,4,7,9,8,3,6,3,8,3,8];

const bubbleSort = (arr) => {
  for(let i=0; i<arr.length; i++){
    for(let j=0; j<arr.length - 1 - i; j++){
      if(arr[j] > arr[j+1]){
        let tmp = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = tmp
      }
    }
  }
}

bubbleSort(arr);
console.log(arr)

/**
 * 2. 实现一个函数，可以对 url 中的 query 部分做拆解，
 * 返回一个 key - value 形式的 object
 */
const url = 'http://sample.com/?a=1&e&b=2&c=xx&d#hash';

const getQueryObj = (url) => {
  var obj = {}

  var str = url.split("?")[1].split("#")[0];
  var arr = str.split("&");
  
  for(let i=0; i<arr.length; i++){
    let strArr = arr[i].split("=")
    if(strArr[1]){
      obj[strArr[0]] = strArr[1]
    }
  }
  return obj
}

console.log(getQueryObj(url)) 
