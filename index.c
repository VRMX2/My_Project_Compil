program isil{
    integer x;
    float y,s;
    integer tab1[20];
    float tab2[34],tab3[30];
    x:=x+2;
    y:=y/3;
    y:=y/x;
    for(i:=1;i<10;i++)
      begin
         x=x+2;
         y=y/x;
      end
    In('%d',x);
    Out('somme %s',x);
}