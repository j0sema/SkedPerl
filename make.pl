
lee_reuniones("Reuniones.txt");
lee_timemaps("Timemap.txt");
lee_tareas("Tareas");

$pos{"Lunes"}=1;
$pos{"Martes"}=2;
$pos{"Miercoles"}=3;
$pos{"Jueves"}=4;
$pos{"Viernes"}=5;

@days=("Lunes","Martes","Miercoles", "Jueves", "Viernes");

main();

sub main(){
   print_agenda();

   exit;
}

sub print_agenda(){
   foreach $d  (@days){
      foreach $h (8..20){
         $indice=$d."-".$h;
         print $indice."\t";
         print "Reunion\t";
         print $semana{$indice}."\n";
      }
   }
   foreach $k  (@tareas){
#      print $k."\n";
      print "$k->{pri} \t";
      print "$k->{nombre} \t";
      print "$k->{duracion} \t";
      print "$k->{due} \t";
      print "$k->{comentarios} \n";

   }
}

sub lee_reuniones("Reuniones.txt"){
   $file =shift;
   open(my $fh, "<", $file) or die "Can't open < $file : $!";
   while (<$fh>){
     chomp();
     @reunion = split /:/,$_;
     $indice=$reunion[0]."-".$reunion[1];
#     print "indice-> ".$indice."\n";
     $i=$reunion[1];
     $semana{$indice}=$reunion[3];
     while ($i < $reunion[2]){
        $indice=$reunion[0]."-".$i;
        $semana{$indice}=$reunion[3];
        $i++;
     }
   }         
  close($fh);
}
# Reuniones
#Lunes:10:12:"Cisco uno"
#Lunes:13:15:"test driven monday 2"
#Lunes:17:18:"reu de lunes"

sub lee_timemaps("Timemap.txt"){
   $file =shift;
   open(my $fh, "<", $file) or die "Can't open < $file : $!";
   while (<$fh>){
     @timemap = split /:/,$_;
     $indice=$timemap[5];
     $day=$timemap[0];
     $$indice_low{$day}=$timemap[3];
     $$indice_high{$day}=$timemap[3];
   }         
  close($fh);
}
#Timemap
#Lunes:08:00:20:00:work
#Martes:08:00:20:00:work
#Miercoles:08:00:20:00:work
#Jueves:08:00:20:00:work

 
sub lee_tareas("Tareas"){
   $file =shift;
   open(my $fh, "<", $file) or die "Can't open < $file : $!";
   while (<$fh>){
     chomp();
     @tarea = split /:/,$_;
     $prioridad=$tarea[0];
     $nombre=$tarea[1];
     $duracion=$tarea[2];
     $due=$tarea[3];
     $comentarios=$tarea[4];
     $tarea{$prioridad}{pri} = $prioridad;
     $tarea{$prioridad}{nombre} = $nombre;
     $tarea{$prioridad}{duracion} = $duracion;
     $tarea{$prioridad}{due} = $due;
     $tarea{$prioridad}{comentarios} = $comentarios;
     $tareas[$prioridad] = $tarea{$prioridad};
   }         
  close($fh);
}

# Tareas
#1:tarea1:10:Lunes:comentarios
#2:tarea2:1:Martes:comentarios
#3:tarea3:1:Juevescomentarios
#4:tarea4:7:Viernes:comentarios

#Reuniones.txt
#Tareas
#Timemap.txt
