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
                RecItem: Record Item;
            begin
                RecItem.Get(Rec."Producto Preferido");
                Message('El Producto Preferido del Cliente %1 es %2', Rec.Name, RecItem.Description);
            end;
        }
    }
}