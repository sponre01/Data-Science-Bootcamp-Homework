Sub HomeworkHard()
 
 Dim Ticker As String
 Range("I" & 1).Value = "Ticker"
 
 Dim Total_Stock_Volume As Double
 Total_Stock_Volume = 0
 Range("J" & 1).Value = "Total Stock Volume"
 
 Dim Summary_Table_Row As Integer
 Summary_Table_Row = 2
 
 Dim last_row As Double
    last_row = Range("A1").End(xlDown).Row

Range("K" & 1).Value = "Yearly Change"
Range("L" & 1).Value = "Percent Change"

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
  
'Column N:
Range("N" & 2).Value = "Greatest % Increase"
Range("N" & 3).Value = "Greatest % Decrease"
Range("N" & 4).Value = "Greatest Total Volume"

'Column O:
Range("O" & 1).Value = "Ticker"

'Column P:
Range("P" & 1).Value = "Value"

Dim last_summary_row As Double
    last_summary_row = Range("K1").End(xlDown).Row
Dim Greatest_Total_Volume As Double
    Greatest_Total_Volume = Cells(2, 10).Value
Dim Greatest_Percent_Increase As Double
    Greatest_Percent_Increase = Cells(2, 12).Value
Dim Greatest_Percent_Decrease As Double
    Greatest_Percent_Decrease = Cells(2, 12).Value
Dim Greatest_Total_Volume_Ticker As String
Dim Greatest_Percent_Increase_Ticker As String
Dim Greatest_Percent_Decrease_Ticker As String
    
For k = 2 To last_summary_row
    'Column K (Yearly Change): format
    If Cells(k, 11).Value < 0 Then
        Cells(k, 11).Interior.ColorIndex = 3 'if negative, make it red
    ElseIf Cells(k, 11).Value > 0 Then
        Cells(k, 11).Interior.ColorIndex = 4 'if positive, make it green
    Else
        Cells(k, 11).Interior.ColorIndex = 5 'if 0, make it blue
    End If
    
    'Column J (10, Total Stock Volume):search for highest value, put in cell P4
    'Put corresponding ticker symbol in O4
    If Cells(k, 10).Value > Greatest_Total_Volume Then
        Greatest_Total_Volume = Cells(k, 10).Value
        Greatest_Total_Volume_Ticker = Cells(k, 9).Value
    End If
    
    'Column L (12, Percent Change):search for highest value, put in cell P2
    'Put corresponding ticker symbol in O2
    If Cells(k, 12).Value > Greatest_Percent_Increase Then
        Greatest_Percent_Increase = Cells(k, 12).Value
        Greatest_Percent_Increase_Ticker = Cells(k, 9).Value
    End If
    
    'search for lowest value, put in cell P3
    'Put corresponding ticker symbol in O3
    If Cells(k, 12).Value < Greatest_Percent_Decrease Then
        Greatest_Percent_Decrease = Cells(k, 12).Value
        Greatest_Percent_Decrease_Ticker = Cells(k, 9).Value
    End If
Next k
    
Range("P" & 4).Value = Greatest_Total_Volume
Range("O" & 4).Value = Greatest_Total_Volume_Ticker
Range("P" & 2).Value = Greatest_Percent_Increase
Range("O" & 2).Value = Greatest_Percent_Increase_Ticker
Range("P" & 3).Value = Greatest_Percent_Decrease
Range("O" & 3).Value = Greatest_Percent_Decrease_Ticker

End Sub