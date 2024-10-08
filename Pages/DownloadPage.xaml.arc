﻿<Page x:Class="LMC.DownloadPage"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
      xmlns:ui="http://schemas.lepo.co/wpfui/2022/xaml"
      xmlns:controls="clr-namespace:Wpf.Ui.Controls;assembly=Wpf.Ui"
      xmlns:local="clr-namespace:LMC"
      mc:Ignorable="d" 
      d:DesignHeight="468" d:DesignWidth="801"
      Title="DownloadPage">

    <Grid>
        <CheckBox x:Name="rel" Content="正式版" Margin="75,47,0,0" VerticalAlignment="Top" Checked="old_Checked" Unchecked="old_Checked"/>
        <CheckBox x:Name="pre" Content="快照版" Margin="75,117,0,0" VerticalAlignment="Top" Checked="old_Checked" Unchecked="old_Checked"/>
<!--#>
        <CheckBox x:Name="spe" Content="lmc.mainui.downloadpage.specials" Margin="75,187,0,0" VerticalAlignment="Top"/>
-->
        <CheckBox x:Name="old" Content="远古版" Margin="75,187,0,0" VerticalAlignment="Top" Checked="old_Checked" Unchecked="old_Checked"/>
        <ListBox x:Name="VersionList" Margin="200,31,188,87" Height="350">
        </ListBox>
        <ui:Button x:Name="confirm" Appearance="Primary" Margin="75,340,0,0" VerticalAlignment="Top" Height="41" Width="107" Content="确认" Click="confirm_Click"/>
    </Grid>
</Page>
