console.log("Sub_category Module...");

var subCateService = (function(){
			
			function get(catecode, callback, error){
				
				$.ajax({
					type:'get',
					url:"/category/" + catecode + ".json",
					success : function(result, status, xhr){
						if(callback){
							callback(result);
						}
					},
					error : function(xhr, status, er){
						if(error){
							error(er);
						}
					}
				});	
			}
			
			return{
				get : get,
			}
		})();