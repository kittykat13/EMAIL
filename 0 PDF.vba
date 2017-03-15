'''''''''''''''''''''''''''''''''''''''''
' PDF.vba - print Excel worksheets to pdf
' Select (highlight) range of sheets 
' To be printed into individual pdfs
Sub pdf()
    Dim ws As Worksheet
    Dim w As String
    
    For Each ws In ActiveWindow.SelectedSheets
        w = ws.Name
      ' Troubleshoot ''''''''''''''''''''''
      ' MsgBox (w)
        ws.Select
        ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, _
      ' Filename:="Path\to\dir" & w & ".pdf", _
        Filename:=w & ".pdf", _
        Quality:=xlQualityStandard, _
        IncludeDocProperties:=True, _
        IgnorePrintAreas:=False, OpenAfterPublish:=False
    Next
End Sub
