codeunit 50001 "CallToWS"
{
    trigger OnRun()
    begin
        tryConnectWS();
    end;

    local procedure tryConnectWS()
    begin
        URL := 'https://api.bluelytics.com.ar/v2/latest';
        Message('Hola 0');
        Client.Get(URL, ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then begin
            Message(ResponseMessage.ReasonPhrase);
            ResponseMessage.Content.ReadAs(Json);

            JsonBufferTMP.ReadFromText(Json);

            Message(Json);

        end;

    end;

    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Json: Text;
        JsonBufferTMP: Record "JSON Buffer" temporary;
        JsonBuffer: Record "JSON Buffer";
        URL: Text[255];
}