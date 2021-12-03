# Read-Bytes

### DESCRIPTION
PowerShell function that reads file bytes using [`System.IO.BinaryReady`](https://docs.microsoft.com/en-us/dotnet/api/system.io.binaryreader?view=net-6.0). It can read all bytes, last `n` bytes (`-Last`) or first `n` bytes (`-First`).<br>
Pipeline compatible with [`System.IO.FileInfo`](https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo?view=net-6.0).

### PARAMETER
- __`-Path <FileInfo>`__ Absolute file path. Alias `FullName`.
- __`[-First <long>]`__ Specifies the number of Bytes from the beginning of a file.
- __`[-Last <long>]`__ Specifies the number of Bytes from the end of a file.
- __`[<CommonParameters>]`__

### OUTPUT `PSCustomObject`

| Name | Type | Description |
|---|---|---|
| `FilePath` | `String` | Absolute path of the file |
| `Length` | `Int64` | File Lenght in Bytes |
| `Bytes` | `Object[]` | Array containing the file bytes |

### REQUIREMENTS
- Tested and compatible with __PowerShell v5.1__ and __PowerShell Core__.


### EXAMPLES

- __`Get-ChildItem . -File | Read-Bytes -Last 100`:__ Reads the last `100` bytes of all files on the current folder. If the `-Last` argument exceeds the file length, it reads the entire file.
- __`Get-ChildItem . -File | Read-Bytes -First 100`:__ Reads the first `100` bytes of all files on the current folder. If the `-First` argument exceeds the file length, it reads the entire file.
- __`Read-Bytes -Path path/to/file.ext`:__ Reads all bytes of `file.ext`.

### OUTPUT

```
FilePath                            Length Bytes
--------                            ------ -----
/home/user/Documents/test/......        14 {73, 32, 119, 111…}
/home/user/Documents/test/......         0 
/home/user/Documents/test/......         0 
/home/user/Documents/test/......         0 
/home/user/Documents/test/......       116 {111, 109, 101, 95…}
/home/user/Documents/test/......     17963 {50, 101, 101, 53…}
/home/user/Documents/test/......      3617 {105, 32, 110, 111…}
/home/user/Documents/test/......       638 {101, 109, 112, 116…}
/home/user/Documents/test/......         0 
/home/user/Documents/test/......        36 {65, 99, 114, 101…}
/home/user/Documents/test/......       735 {117, 112, 46, 79…}
/home/user/Documents/test/......      1857 {108, 111, 115, 101…}
/home/user/Documents/test/......        77 {79, 80, 69, 78…}
```
