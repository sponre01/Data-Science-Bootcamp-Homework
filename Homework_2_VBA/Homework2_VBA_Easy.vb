Sub VBAHomeworkEasy()

Sub HomeworkEasy()
 
 'Ticker symbol (P, PAA, etc): for column I (9)
 Dim Ticker As String
 Range("I" & 1).Value = "Ticker"
 
 'Total Volume (large number): for column J (10)
 Dim Total_Stock_Volume As Double
 Total_Stock_Volume = 0
 Range("J" & 1).Value = "Total Stock Volume"
 
 'Summary Table in columns I and J
 Dim Summary_Table_Row As Integer
 Summary_Table_Row = 2
 
 'Last row of source data in columns A and B
 Dim last_row As Double
    last_row = Range("A1").End(xlDown).Row

'For all rows of source data, if the Ticker symbol in one row is not equal
'to the ticker symbol in the previous row, then we have reached the end of
'a ticker grouping. Assign the ticker symbol to "Ticker" and add the last
'volume in the grouping to "Total Stock Volume." Put the Ticker in column I
'and the Total Stock Volume in column J, in the current row. If the ticker
'symbol for the current and next row are equal, then just add the volume
'to the total stock volume and move to the next row of source data.

  For i = 2 To last_row
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
        Ticker = Cells(i, 1).Value
        Total_Stock_Volume = Total_Stock_Volume + Cells(i, 7).Value
        Range("I" & Summary_Table_Row).Value = Ticker
        Range("J" & Summary_Table_Row).Value = Total_Stock_Volume
        
        'reset the table for the next iteration of i: add one to the current
        'row, and reset the total stock volume to 0
        Summary_Table_Row = Summary_Table_Row + 1
        Total_Stock_Volume = 0
        
        Else
        Total_Stock_Volume = Total_Stock_Volume + Cells(i, 7).Value
        
    End If

  Next i
  
End Sub
