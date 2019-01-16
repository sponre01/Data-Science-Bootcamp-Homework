Sub HomeworkModerate()
 
 Dim Ticker As String
 Range("I" & 1).Value = "Ticker"
 
 Dim Total_Stock_Volume As Double
 Total_Stock_Volume = 0
 Range("J" & 1).Value = "Total Stock Volume"
 
 Dim Summary_Table_Row As Integer
 Summary_Table_Row = 2
 
 Dim last_row As Double
    last_row = Range("A1").End(xlDown).Row

'Put Yearly Change in column K and Percent Change in column L
Range("K" & 1).Value = "Yearly Change"
Range("L" & 1).Value = "Percent Change"

'To do the math, we'll need to search for the Year Open number and Close number
 Dim Year_Open As Double
    Year_Open = Cells(2, 3).Value
 Dim Year_Close As Double

  For i = 2 To last_row
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
        Ticker = Cells(i, 1).Value
        Total_Stock_Volume = Total_Stock_Volume + Cells(i, 7).Value
        Year_Close = Cells(i, 6).Value
        Range("I" & Summary_Table_Row).Value = Ticker
        Range("J" & Summary_Table_Row).Value = Total_Stock_Volume
        
        If Year_Open = 0 Then
            Range("K" & Summary_Table_Row).Value = 0
            Range("L" & Summary_Table_Row).Value = 0
        Else
            Range("K" & Summary_Table_Row).Value = Year_Close - Year_Open
            Range("L" & Summary_Table_Row).Value = (Year_Close - Year_Open) / Year_Open
        End If
        
        Summary_Table_Row = Summary_Table_Row + 1
        Total_Stock_Volume = 0
        Year_Open = Cells(i + 1, 3).Value
        
     Else
        Total_Stock_Volume = Total_Stock_Volume + Cells(i, 7).Value
        
    End If

  Next i
  
'Conditional Formatting of Column K (Yearly Change)
Dim last_summary_row As Double
    last_summary_row = Range("K1").End(xlDown).Row
    
For k = 2 To last_summary_row
    If Cells(k, 11).Value < 0 Then
        Cells(k, 11).Interior.ColorIndex = 3 'if negative, make it red
    ElseIf Cells(k, 11).Value > 0 Then
        Cells(k, 11).Interior.ColorIndex = 4 'if positive, make it green
    Else
        Cells(k, 11).Interior.ColorIndex = 5 'if 0, make it blue
    End If
Next k

End Sub