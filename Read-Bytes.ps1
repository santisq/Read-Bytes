function Read-Bytes {
[cmdletbinding(DefaultParameterSetName = 'Path')]
param(
    [parameter(
        Mandatory,
        ValueFromPipelineByPropertyName,
        ParameterSetName = 'Path',
        Position = 0
    )][alias('FullName')]
    [ValidateScript({ 
        if(Test-Path $_ -PathType Leaf)
        {
            return $true
        }
        throw 'Invalid File Path'
    })]
    [System.IO.FileInfo]$Path,
    [parameter(
        HelpMessage = 'Specifies the number of Bytes from the beginning of a file.',
        ParameterSetName = 'FirstBytes',
        Position = 1
    )]
    [int64]$First,
    [parameter(
        HelpMessage = 'Specifies the number of Bytes from the end of a file.',
        ParameterSetName = 'LastBytes',
        Position = 1
    )]
    [int64]$Last
)

    process
    {
        try
        {
            $reader = [System.IO.BinaryReader]::new(   
                [System.IO.File]::Open(
                    $Path.FullName,
                    [system.IO.FileMode]::Open,
                    [System.IO.FileAccess]::Read
                )
            )

            $stream = $reader.BaseStream
            
            $length = (
                $stream.Length, $First
            )[[int]($First -lt $stream.Length -and $First)]

            $stream.Position = (
                0, ($length - $Last)
            )[[int]($length -gt $Last -and $Last)]
            
            $bytes = while($stream.Position -ne $length)
            {
                $stream.ReadByte()
            }

            [pscustomobject]@{
                FilePath = $Path.FullName
                Length = $length
                Bytes = $bytes
            }
        }
        catch
        {
            Write-Warning $_.Exception.Message
        }
        finally
        {
            $reader.Close()
            $reader.Dispose()
        }
    }
}
