pageextension 50000 "Cliente Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Producto Preferido"; Rec."Producto Preferido")
            {
                ApplicationArea = All;
            }
        }
    }
}