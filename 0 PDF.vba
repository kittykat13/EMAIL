''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' PDF.vba - print a range of sheets into individual pdfs

sub pdf()
    ThisWorkbook.Sheets("Sheet").Select
    ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, Filename:= _
        "Sheet.pdf", Quality:= xlQualityStandard, IncludeDocProperties:=True, _
        IgnorePrintAreas:=False, OpenAfterPublish:=True
    
end sub
