//Juan Vazquez 
//https://github.com/javazquez
//http://javazquez.com

//ones are used 100 for each hundered ex->one hundred...one hundred and ninety-nine
//ones are used 90 for 1-99 ..so they are used 190 times
//one thousand is 11 chars

--start code---
var ones= ['one','two', 'three','four','five','six','seven','eight','nine'];
var tens = ['ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen', 'nineteen'];
var tys = ['twenty', 'thirty','forty','fifty','sixty','seventy', 'eighty', 'ninety'];
//each argument is array of (array,multiplier)
function sumUpArgs(){
    var ans =0;
    for(var j=0; j<arguments.length;j++){
        for(var k=0;k<arguments[j][0].length;k++){
            ans+= arguments[j][0][k].length*arguments[j][1];
        }
}
    return ans;
}

function sumup(inlist,multiplier){
    var ans =0;
    for(var k=0;k<inlist.length;k++){
        ans+=inlist[k].length*multiplier;
    }
    return ans;
}
var hundredcnt = 7*100*9;
var andcnt = 3*99*9;

console.log( sumUpArgs([ones,190],[tens,10],[tys,100])+11+hundredcnt+andcnt);
//21124


