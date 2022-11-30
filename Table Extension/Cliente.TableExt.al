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
            var
            // RecItem: Record Item;
            begin
                // RecItem.Get(Rec."Producto Preferido");
                // Message('Se añadió un Producto Preferido');

                if xRec."Producto Preferido" <> Rec."Producto Preferido" then
                    if Confirm('¿Desea confirmar el Nuevo Producto Preferido?') then
                        Message('Se añadió un Producto Preferido');
            end;
        }
    }
}