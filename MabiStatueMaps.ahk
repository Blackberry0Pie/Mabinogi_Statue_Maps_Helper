;v0.5
global minimized = 0
global onTreasure = 0

pLappa := A_WorkingDir . "\MabiStatueMaps\Lappa.c.png"
pLaTerra := A_WorkingDir . "\MabiStatueMaps\LaTerra.c.png"
pHerba := A_WorkingDir . "\MabiStatueMaps\HerbaJungle.c.png"
pPanty := A_WorkingDir . "\MabiStatueMaps\PantySwamp.c.png"
pCor := A_WorkingDir . "\MabiStatueMaps\Cor.c.png"
pCenae := A_WorkingDir . "\MabiStatueMaps\CenaeMeadows.c.png"
pMaskPuzzle := A_WorkingDir . "\MabiStatueMaps\MaskPuzzle.c.png"
pNumber1 := A_WorkingDir . "\MabiStatueMaps\Number1.c.png"
pNumber2 := A_WorkingDir . "\MabiStatueMaps\Number2.c.png"
pNumber3 := A_WorkingDir . "\MabiStatueMaps\Number3.c.png"
pNumber4 := A_WorkingDir . "\MabiStatueMaps\Number4.c.png"
pNumber5 := A_WorkingDir . "\MabiStatueMaps\Number5.c.png"
pKey := A_WorkingDir . "\MabiStatueMaps\Key.c.png"

gui:
  Gui, Add, Button, x2 y2 w40 h15 glappa, Lappa
  Gui, Add, Button, x44 y2 w50 h15 glaterra, La Terra
  Gui, Add, Button, x96 y2 w45 h15 gherba, Herba
  Gui, Add, Button, x143 y2 w45 h15 gpanty, Pantay
  Gui, Add, Button, x190 y2 w30 h15 gcor, Cor
  Gui, Add, Button, x222 y2 w45 h15 gcenae, Cenae
  Gui, Add, Button, x269 y2 w50 h15 gtreasure, Treasure
  Gui, Add, Button, x321 y2 w25 h15 gkey, Key
  Gui, Add, button, x348 y2 w23 h15 gminimize vminbutton, -

  Gui, Color, FF00FF
  Gui +LastFound
  WinSet, TransColor, FF00FF
  Gui +AlwaysOnTop -Caption
  Gui, Add, Picture, x2 y19 w370 h354 vPicture guiMove, %pLappa%
  Gui, Add, Picture, x64 y27 w40 h64 vmask1 BackgroundTrans hidden, %pNumber1%
  Gui, Add, Picture, x270 y27 w40 h64 vmask2 BackgroundTrans hidden, %pNumber2%
  Gui, Add, Picture, x168 y110 w40 h64 vmask3 BackgroundTrans hidden, %pNumber3%
  Gui, Add, Picture, x59 y193 w40 h64 vmask4 BackgroundTrans hidden, %pNumber4%
  Gui, Add, Picture, x280 y185 w40 h64 vmask5 BackgroundTrans hidden, %pNumber5%
  Gui, Show, x410 y267 h374 w374, MabiStatueMaps
return

GuiClose:
ExitApp

uiMove:
  PostMessage, 0xA1, 2,,, A ;click and drag this control to move the window
return

redraw(image){
  onTreasure = 0
  minimized = 0
  GuiControl,, minbutton, -
  GuiControl, Hide, mask1
  GuiControl, Hide, mask2
  GuiControl, Hide, mask3
  GuiControl, Hide, mask4
  GuiControl, Hide, mask5
  GuiControl, -Redraw, Picture
  GuiControl,, Picture, %image%
  GuiControl, +Redraw, Picture
}

lappa:
  redraw(pLappa)
return

laterra:
  redraw(pLaTerra)
return

herba:
  redraw(pHerba)
return

panty:
  redraw(pPanty)
return

cor:
  redraw(pCor)
return

cenae:
  redraw(pCenae)
return

^r::
  reload
return

treasure:
  supriseY = sadnessY = angerY = happyY = sleepY = 0
  supriseOrder = sadnessOrder = angerOrder = happyOrder = sleepOrder = 0
  IfWinExist, Mabinogi
  {
    WinActivate, Mabinogi
    WinGetPos,X,Y,W,H
  }
  loop, 3 {
    imagesearch,sX,sY,X+50,H-270,W-50,H,*20 *Trans0xFF00FF %A_WorkingDir%\MabiStatueMaps\suprise%A_Index%.c.png
    if(errorlevel=0){
      supriseY := sY
      supriseOrder = 1
      break
    }
  }
  loop, 3 {
    imagesearch,sX,sY,X+50,H-270,W-50,H,*20 *Trans0xFF00FF %A_WorkingDir%\MabiStatueMaps\sadness%A_Index%.c.png
    if(errorlevel=0){
      sadnessY := sY
      sadnessOrder = 2
      if(sadnessY < supriseY){
        sadnessOrder -= 1
        supriseOrder += 1
      }
      break
    }
  }
  loop, 3 {
    imagesearch,sX,sY,X+50,H-270,W-50,H,*20 *Trans0xFF00FF %A_WorkingDir%\MabiStatueMaps\anger%A_Index%.c.png
    if(errorlevel=0){
      angerY := sY
      angerOrder = 3
      if(angerY < supriseY){
        angerOrder -= 1
        supriseOrder += 1
      }
      if(angerY < sadnessY){
        angerOrder -= 1
        sadnessOrder += 1
      }
      break
    }
  }
  loop, 3 {
    imagesearch,sX,sY,X+50,H-270,W-50,H,*20 *Trans0xFF00FF %A_WorkingDir%\MabiStatueMaps\happy%A_Index%.c.png
    if(errorlevel=0){
      happyY := sY
      happyOrder = 4
      if(happyY < supriseY){
        happyOrder -= 1
        supriseOrder += 1
      }
      if(happyY < sadnessY){
        happyOrder -= 1
        sadnessOrder += 1
      }
      if(happyY < angerY){
        happyOrder -= 1
        angerOrder += 1
      }
      break
    }
  }
  loop, 3 {
    imagesearch,sX,sY,X+50,H-270,W-50,H,*20 *Trans0xFF00FF %A_WorkingDir%\MabiStatueMaps\sleep%A_Index%.c.png
    if(errorlevel=0){
      sleepY := sY
      sleepOrder = 5
      if(sleepY < supriseY){
        sleepOrder -= 1
        supriseOrder += 1
      }
      if(sleepY < sadnessY){
        sleepOrder -= 1
        sadnessOrder += 1
      }
      if(sleepY < angerY){
        sleepOrder -= 1
        angerOrder += 1
      }
      if(sleepY < happyY){
        sleepOrder -= 1
        happyOrder += 1
      }
      break
    }
  }

if(supriseOrder && sadnessOrder && angerOrder && happyOrder && sleepOrder){
  redraw(pMaskPuzzle)
  mask1 := "pNumber" . supriseOrder
  mask2 := "pNumber" . sadnessOrder
  mask3 := "pNumber" . angerOrder
  mask4 := "pNumber" . happyOrder
  mask5 := "pNumber" . sleepOrder
  GuiControl,, mask1,% %mask1%
  GuiControl,, mask2,% %mask2%
  GuiControl,, mask3,% %mask3%
  GuiControl,, mask4,% %mask4%
  GuiControl,, mask5,% %mask5%
  GuiControl,Show , mask1
  GuiControl,Show , mask2
  GuiControl,Show , mask3
  GuiControl,Show , mask4
  GuiControl,Show , mask5
  onTreasure = 1
}
return

key:
  redraw(pKey)
return

minimize:
  if(minimized){
    minimized = 0
    GuiControl,Show,Picture
    GuiControl,, minbutton, -
    if(onTreasure){
      GuiControl,Show , mask1
      GuiControl,Show , mask2
      GuiControl,Show , mask3
      GuiControl,Show , mask4
      GuiControl,Show , mask5
    }
  } else {
    minimized = 1
    GuiControl,Hide,Picture
    GuiControl,, minbutton, [+]
    if(onTreasure){
      GuiControl,Hide , mask1
      GuiControl,Hide , mask2
      GuiControl,Hide , mask3
      GuiControl,Hide , mask4
      GuiControl,Hide , mask5
    }
  }
return