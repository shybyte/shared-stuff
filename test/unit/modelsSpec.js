/* jasmine specs for controllers go here */

describe('Stuff', function () {
    beforeEach(function () {

    });

    it('should use contructor props', function () {
        var stuff = new Stuff({title:'Title String',description:'Description String'});
        expect(stuff.title).toEqual('Title String');
        expect(stuff.description).toEqual('Description String');
    });

    it('id is a string', function () {
        var stuff = new Stuff();
        expect(typeof stuff.id).toEqual('string');
    });

});