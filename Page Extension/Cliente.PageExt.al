pageextension 50000 "Cliente Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Producto Preferido"; Rec."Producto Preferido")
            {
                ApplicationArea = All;
                Editable = true;
                Caption = 'Fav Item', Comment = 'ESP="Producto Preferido"';
            }
            field("Nombre Producto Preferido"; Rec."Nombre Producto Preferido")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Fav Item Description', Comment = 'ESP="Nombre Prod. Preferido"';
            }
        }
    }
}