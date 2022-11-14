//
//  ConnectToExternalDevViewController.swift
//  Capture
//
//  Created by Consultant on 9/26/22.
//

import UIKit
import CoreBluetooth

class ConnectToExternalDevViewController: UIViewController {

    var centralManager: CBCentralManager!
    let audioServiceCBUUID = CBUUID(string: "0x01")
    let audioCharacteristicCBUUID = CBUUID(string: "0000")
    var audioPeripheral: CBPeripheral!


    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
}
extension ConnectToExternalDevViewController: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       
        switch central.state {

        case .unknown:
            print("Central.state is .unknown")
        case .resetting:
            print("Central.state is .resetting")
        case .unsupported:
            print("Central.state is .unsupported")
        case .unauthorized:
            print("Central.state is .unauthorized")
        case .poweredOff:
            print("Central.state is .poweredOff")
        case .poweredOn:
            print("Central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: [audioServiceCBUUID])
        @unknown default:
            print("Central.state ")
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print(peripheral)
        audioPeripheral = peripheral
        centralManager.stopScan()
        centralManager.connect(audioPeripheral)
        audioPeripheral.delegate = self

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        audioPeripheral.discoverServices([audioServiceCBUUID])

    }
    
}
extension ConnectToExternalDevViewController: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard let services = peripheral.services else { return }

        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            print(characteristic)
            if characteristic.properties.contains(.read) {
                print("\(characteristic.uuid): properties contains .read")
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
            }
            peripheral.readValue(for: characteristic)

        }

    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
      switch characteristic.uuid {
        case audioCharacteristicCBUUID:
          print(characteristic.value ?? "no value")
        default:
          print("Unhandled Characteristic UUID: \(characteristic.uuid)")
      }
    }


}

