# code for test_deep_copy.sv
  ...
     module test_deep_copy;


        // In class parity_calc_c

        class parity_calc_c;

                // Declare parity (bit type, size 8), initialize it with some random value
                bit [7:0]parity=10;
                // Write copy method that returns parity_calc_c class type
                function parity_calc_c copy();
                        // Create copy instance
                        copy = new();
                        // Copy all the current properties into copy object
                        copy.parity=this.parity;
                endfunction

        endclass: parity_calc_c
// In class packet_c

        class packet_c;

                // Declare header (bit type , size 8), initialize it with some random value
                bit [7:0]header=20;
                // Declare data (bit type , size 8), initialize it with some random value
                bit [7:0]data=30;
                // Declare and create an instance of parity_calc_c
                parity_calc_c pcc=new();
                // Define copy method that returns packet_c class type
                function packet_c copy();
                        // Create copy instance
                        copy = new();
                        // Copy all the current class properties into copy object
                        copy.header=this.header;
                        copy.data=this.data;
                        copy.pcc=this.pcc.copy;
                endfunction
        endclass: packet_c

        // Declare 2 handles pkt_h1 & pkt_h2 for packet_c class
        packet_c pkt_h1,pkt_h2;

        // Within initial
        initial
        begin
                // Create pkt_h1 object
                pkt_h1=new();
          
                // Use shallow copy method to copy pkt_h1 to pkt_h2
                pkt_h2=new pkt_h1;
          
                // Display the properties of parent class and sub class properties of pkt_h1 and pkt_h2
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
                $display("header=%p,data=%p,parity=%p",pkt_h2.header,pkt_h2.data,pkt_h2.pcc.parity);
          
                // Assign random value to the header of pkt_h2
                pkt_h2.header=50;
          
                // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
                // observe pkt_h1.header does not change
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
          
                // observe pkt_h1.header does not change
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
                $display("header=%p,data=%p,parity=%p",pkt_h2.header,pkt_h2.data,pkt_h2.pcc.parity);
          
                // Change parity of pkt_h2 using subclass handle from the parent class packet_c
                // Ex: pkt_h2.par.parity=19;
                pkt_h2.pcc.parity=40;
          
                // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
                // observe that change reflected in pkt_h1 as the subclass handle in pkt_h1 and pkt_h2 are pointing to same subclass object
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
                $display("header=%p,data=%p,parity=%p",pkt_h2.header,pkt_h2.data,pkt_h2.pcc.parity);
          
                // Perform deep copy by calling parent class copy method
                // Ex: pkt_h2=pkt_h1.copy;
                pkt_h2=pkt_h1.copy;
          
                // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
                // observe the parent and subclass properties
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
                $display("header=%p,data=%p,parity=%p",pkt_h2.header,pkt_h2.data,pkt_h2.pcc.parity);
          
                // Change parity of pkt_h2
                // Ex: pkt_h2.par.parity=210;
                pkt_h2.pcc.parity=210;
          
                // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
                // observe that parity doesnot change for pkt_h1 as they are two different subclass objects
                $display("header=%p,data=%p,parity=%p",pkt_h1.header,pkt_h1.data,pkt_h1.pcc.parity);
                $display("header=%p,data=%p,parity=%p",pkt_h2.header,pkt_h2.data,pkt_h2.pcc.parity);
        end
endmodule
...
