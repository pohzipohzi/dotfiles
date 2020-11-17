package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
)

const (
	SCANNER_BUF_SIZE = 2 << 20

	INF = int64(math.MaxInt64)
	MOD = 1e9 + 7
)

var (
	writer  *bufio.Writer
	scanner *bufio.Scanner
)

func init() {
	writer = bufio.NewWriter(os.Stdout)
	scanner = bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	scanner.Buffer(make([]byte, SCANNER_BUF_SIZE), SCANNER_BUF_SIZE)
}

func printf(f string, a ...interface{}) {
	fmt.Fprintf(writer, f, a...)
}

func sint64() int64 {
	scanner.Scan()
	bb := scanner.Bytes()
	i := int64(0)
	if bb[0] == '-' {
		for _, b := range bb[1:] {
			i *= 10
			i -= int64(b - '0')
		}
		return i
	}
	for _, b := range bb {
		i *= 10
		i += int64(b - '0')
	}
	return i
}

func suint64() uint64 {
	scanner.Scan()
	bb := scanner.Bytes()
	i := uint64(0)
	for _, b := range bb {
		i *= 10
		i += uint64(b - '0')
	}
	return i
}

func sstring() string {
	scanner.Scan()
	return scanner.Text()
}

func sbytes() []byte {
	scanner.Scan()
	return scanner.Bytes()
}

func main() {
	defer writer.Flush()

}
