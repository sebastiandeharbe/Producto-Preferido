pageextension 50000 "Cliente Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Fav Item"; Rec."Producto Preferido")
            {
                ApplicationArea = All;
            }
        }
    }
}