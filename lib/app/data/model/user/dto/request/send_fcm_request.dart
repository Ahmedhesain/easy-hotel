class SendFcmRequest {
  SendFcmRequest({
    this.tobic,
    this.title,
    this.body,
  });

  String? tobic;
  String? title;
  String? body;

  Map<String, dynamic> toJson() => {
    "to": "/topics/$tobic",
    "notification":{
      "body":body,
      "title":title
    },
    // "data":{
    //   if(invoiceId != null)
    //     "invoiceId": invoiceId
    // }
  };

}
