Mediumlarge.Models.Post = Backbone.Model.extend({
  urlRoot: "/posts", 
  
  toJSON:function(options){
    var payload = _.extend({}, this.attributes);
    
    return { 
        title : this.get('title'),
        subtitle : this.get('subtitle'),
        body: this.get('body'), 
        publish_status : this.get('publish_status')
    }
  }
});
