package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const FILENAME = "C-large"
const INPUT_FILE = FILENAME + ".in"

func main() {

	file, err := os.Open(INPUT_FILE)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	lineCount, _ := strconv.ParseInt(scanner.Text(), 10, 32)
	for i := 1; i <= int(lineCount); i++ {
		scanner.Scan()
		c := strings.Split(scanner.Text(), " ")
		n, _ := strconv.ParseInt(c[0], 10, 32)
		j, _ := strconv.ParseInt(c[1], 10, 32)

		fmt.Printf("Case #%d:\n", i)
		runCase(int(n), int(j))
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

}

func runCase(n, j int) (output string) {
	strBegin := "1"
	strEnd := "1"
	for i := 1; i < n; i++ {
		strBegin = strBegin + "0"
		strEnd = strEnd + "1"
	}

	begin, _ := strconv.ParseInt(strBegin, 2, 64)
	end, _ := strconv.ParseInt(strEnd, 2, 64)

	for i := begin; i <= end && j > 0; i++ {
		str := strconv.FormatInt(i, 2)
		if isCoinJam, divisors := checkCoinJam(str); isCoinJam == true {
			line := fmt.Sprintln(str, divisors)

			line = strings.Replace(line, "[", "", 1)
			line = strings.Replace(line, "]", "", 1)

			fmt.Print(line)
			output += line
			j--
		}
	}
	return output
}

func checkCoinJam(str string) (isCoinJam bool, divisors []int) {

	if str[0:1] == "0" || str[len(str)-1:len(str)] == "0" {
		return
	}

	isCoinJam = true
	for b := 2; b <= 10; b++ {
		i, _ := strconv.ParseInt(str, b, 64)
		n := int(i)
		if isPrime, divisor := checkPrime(n); isPrime == true {
			isCoinJam = false
			break
		} else {
			divisors = append(divisors, divisor)
		}
	}
	return
}

var primeMap map[int]int

func checkPrime(n int) (isPrime bool, divisor int) {

	if primeMap == nil {
		primeMap = make(map[int]int)
	}

	if n < 2 {
		isPrime = false
		return
	} else if n == 2 {
		isPrime = true
		primeMap[n] = 0
		return
	} else {

		if val, ok := primeMap[n]; ok {
			if val > 0 {
				isPrime = false
				divisor = val
			} else {
				isPrime = true
			}
			return
		}

		count := 0
		half := n / 2
		for i := 2; i <= half; i += 1 {
			count += 1
			// Don't check too much, waste of energy
			if count > 1000 {
				isPrime = true
				primeMap[n] = 0
				return
			}

			if n%i == 0 {
				isPrime = false
				primeMap[n] = i
				divisor = i
				return
			}
		}
		isPrime = true
		primeMap[n] = 0

		return
	}
}
