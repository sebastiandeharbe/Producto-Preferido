tableextension 50000 "Cliente Extendido" extends Customer
{
    fields
    {
        field(50000; "Producto Preferido"; Code[20])
        {
            TableRelation = Item."No.";
            ValidateTableRelation = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                if xRec."Producto Preferido" <> Rec."Producto Preferido" then
                    if Confirm('¿Desea confirmar el Nuevo Producto Preferido?') then begin
                        Item.Reset();
                        Item.SetRange("No.", Rec."Producto Preferido");
                        if Item.FindFirst() then begin
                            "Nombre Producto Preferido" := Item.Description;
                            Rec.Modify(true);
                        end;
                        Message('Se añadió un Producto Preferido');
                    end;

                //comentario de prueba
            end;
        }
        field(50001; "Nombre Producto Preferido"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        Item: Record Item;

}